//
//  TreeNode.swift
//  AlgoBase
//
//  Created by ryfang on 2022/10/16.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// lc116
public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

public extension Node {
    func nextArray() -> [Any] {
        var result = [Any]()
        var tree: [Node] = [self]
        while !tree.isEmpty {
            guard tree.count > 0 else { break }
            var node: Node? = tree[0]
            while node != nil {
                guard let tmp = node else { break }
                result.append(tmp.val)
                node = tmp.next
            }
            result.append("#")
            tree = tree.flatMap { [$0.left, $0.right].compactMap { $0 } }
        }
        return result
    }

    func array() -> [Int?] {
        var result = [Int?]()
        var tree: [Node?] = [self]
        while !tree.isEmpty {
            guard tree.compactMap({ $0 }).count > 0 else { break }
            result.append(contentsOf: tree.map { $0?.val })
            tree = tree.compactMap { $0 }.flatMap { [$0?.left, $0?.right] }
        }
        // remove nils at last
        while let last = result.last, last == nil {
            result.removeLast()
        }
        return result
    }

    static func arrayToNode(_ nums: [Int?]) -> Node? {
        guard nums.count > 0 else { return nil }
        guard let rootVal = nums[0] else { return nil }
        let root = Node(rootVal)
        var queue: [Node?] = [root]
        var i = 1
        let sz = nums.count
        while !queue.isEmpty && i < sz {
            let node = queue.removeFirst()
            if let val = nums[i] {
                let left = Node(val)
                node?.left = left
                queue.append(left)
            }
            i += 1
            if i >= sz {
                break
            }
            if let val = nums[i] {
                let right = Node(val)
                node?.right = right
                queue.append(right)
            }
            i += 1
        }
        return root
    }
}

// !!!: Constructor
public extension TreeNode {
    func array() -> [Int?] {
        var result = [Int?]()
        var tree: [TreeNode?] = [self]
        while !tree.isEmpty {
            guard tree.compactMap({ $0 }).count > 0 else { break }
            result.append(contentsOf: tree.map { $0?.val })
            tree = tree.compactMap { $0 }.flatMap { [$0?.left, $0?.right] }
        }
        // remove nils at last
        while let last = result.last, last == nil {
            result.removeLast()
        }
        return result
    }

    func _array() -> [Int?] {
        var ans: [Int?] = []
        var queue: [TreeNode?] = [self]
        while !queue.isEmpty {
            guard let node = queue.removeFirst() else {
                ans.append(nil)
                continue
            }
            ans.append(node.val)
            queue.append(node.left)
            queue.append(node.right)
        }
        // remove nils at last
        while let last = ans.last, last == nil {
            ans.removeLast()
        }
        return ans
    }

    // TODO: to be optimized
    static func arrayToTree(_ nums: [Int?]) -> TreeNode? {
        guard nums.count > 0 else { return nil }
        guard let rootVal = nums[0] else { return nil }
        let root = TreeNode(rootVal)
        var queue: [TreeNode?] = [root]
        var i = 1
        let sz = nums.count
        while !queue.isEmpty && i < sz {
            let node = queue.removeFirst()
            if let val = nums[i] {
                let left = TreeNode(val)
                node?.left = left
                queue.append(left)
            }
            i += 1
            if i >= sz {
                break
            }
            if let val = nums[i] {
                let right = TreeNode(val)
                node?.right = right
                queue.append(right)
            }
            i += 1
        }
        return root
    }
}

// MARK: fileprivate
//extension TreeNode: Equatable {
//    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
//        return lhs.val == rhs.val && lhs.left == rhs.left && lhs.right == rhs.right
//    }
//}

// MARK: - Recursive Traversal
public extension TreeNode {
    static func inOrder(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        func _inorder(_ node: TreeNode?, _ res: inout [Int]) {
            guard let node = node else { return }
            _inorder(node.left, &res)
            res.append(node.val)
            _inorder(node.right, &res)
        }
        _inorder(root, &ans)
        return ans
    }

    static func preOrder(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        func _preorder(_ node: TreeNode?, _ res: inout [Int]) {
            guard let node = node else { return }
            res.append(node.val)
            _preorder(node.left, &res)
            _preorder(node.right, &res)
        }
        _preorder(root, &ans)
        return ans
    }

    static func postOrder(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        func _postorder(_ node: TreeNode?, _ res: inout [Int]) {
            guard let node = node else { return }
            _postorder(node.left, &res)
            _postorder(node.right, &res)
            res.append(node.val)
        }
        _postorder(root, &ans)
        return ans
    }
}

// MARK: - Iteratively Traversal
public extension TreeNode {
    // 左根右
    static func inOrderIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [TreeNode]()
        var node: TreeNode? = root
        while !stack.isEmpty || node != nil {
            while let tmp = node {
                stack.append(tmp)
                node = tmp.left
            }
            let top = stack.removeLast()
            ans.append(top.val)
            node = top.right
        }
        return ans
    }

    // 根左右
    static func preOrderIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [TreeNode]()
        var node: TreeNode? = root
        while !stack.isEmpty || node != nil {
            while let tmp = node {
                stack.append(tmp)
                ans.append(tmp.val)
                node = tmp.left
            }
            let top = stack.removeLast()
            node = top.right
        }
        return ans
    }

    // 右右根
    static func postOrderIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [TreeNode]()
        var node: TreeNode? = root
        while !stack.isEmpty || node != nil {
            while let tmp = node {
                stack.append(tmp)
                ans.insert(tmp.val, at: 0)
                node = tmp.right
            }
            let top = stack.removeLast()
            node = top.left
        }
        return ans
    }
}

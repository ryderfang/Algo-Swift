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

    func leafs() -> [TreeNode] {
        var ans = [TreeNode]()
        if left == nil && right == nil {
            ans.append(self)
        } else {
            ans.append(contentsOf: left?.leafs() ?? [])
            ans.append(contentsOf: right?.leafs() ?? [])
        }
        return ans
    }

    func copy() -> TreeNode {
        let node = TreeNode(val)
        node.left = left?.copy()
        node.right = right?.copy()
        return node
    }

    func hash() -> String {
        let arr = _array()
        return arr.map {
            if let x = $0 { return String(x) }
            else { return "null" }
        }.joined(separator: ",")
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
extension TreeNode/*: Equatable*/ {
    fileprivate static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

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
    // 中序（左根右）
    static func inOrderIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [TreeNode]()
        var curr: TreeNode? = root
        while !stack.isEmpty || curr != nil {
            while let tmp = curr {
                stack.append(tmp)
                curr = tmp.left
            }
            let top = stack.removeLast()
            ans.append(top.val)
            curr = top.right
        }
        return ans
    }

    // 前序（根左右）
    static func preOrderIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [root]
        while !stack.isEmpty {
            let top = stack.removeLast()
            ans.append(top.val)
            // 子节点逆序入栈 (lc589)
            stack.append(contentsOf: [top.right, top.left].compactMap { $0 })
        }
        return ans
    }

    // 后序（左右根）
    static func postOrderIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [root]
        while !stack.isEmpty {
            let top = stack.removeLast()
            ans.insert(top.val, at: 0)
            // 子节点顺序入栈 (lc590)
            stack.append(contentsOf: [top.left, top.right].compactMap { $0 })
        }
        return ans
    }
}


public extension TreeNode {
    static func inOrderIterative2(_ root: TreeNode?) -> [Int] {
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

    static func preOrderIterative2(_ root: TreeNode?) -> [Int] {
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

    static func postOrderIterative2(_ root: TreeNode?) -> [Int] {
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

// * Can't import module in LeetCode.
import ObjectiveC.runtime

// m337
fileprivate extension TreeNode {
    enum StoreKey {
        static var key1 = "key1"
        static var key2 = "key2"
    }
    var robSelf: Int {
        get {
            (objc_getAssociatedObject(self, &StoreKey.key1) as? NSNumber)?.intValue ?? -1
        }
        set {
            objc_setAssociatedObject(self, &StoreKey.key1, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN)
        }
    }
    var notRobSelf: Int {
        get {
            (objc_getAssociatedObject(self, &StoreKey.key2) as? NSNumber)?.intValue ?? -1
        }
        set {
            objc_setAssociatedObject(self, &StoreKey.key2, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

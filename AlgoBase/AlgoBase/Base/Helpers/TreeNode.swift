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

public extension TreeNode {
    func array() -> [Int?] {
        var ans: [Int?] = []
        var queue: [TreeNode?] = [self]
        while !queue.isEmpty {
            if let node = queue.removeFirst() {
                ans.append(node.val)
                queue.append(node.left)
                queue.append(node.right)
            } else {
                ans.append(nil)
            }
        }
        // remove nils at last
        while ans.last == nil {
            ans.removeLast()
        }
        return ans
    }

    // level traversal
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

// MARK: - Recursive Traversal
public extension TreeNode {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
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

    func preorderTraversal(_ root: TreeNode?) -> [Int] {
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

    func postorderTraversal(_ root: TreeNode?) -> [Int] {
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
    func inorderTraversal_i(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var stack = [TreeNode]()
        var node = root
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node!)
                node = node?.left
            }
            let top = stack.popLast()
            ans.append(top!.val)
            node = top!.right
        }
        return ans
    }

    func preorderTraversal_i(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var stack = [TreeNode]()
        var node = root
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node!)
                ans.append(node!.val)
                node = node!.left
            }
            let top = stack.popLast()
            node = top!.right
        }
        return ans
    }

    func postorderTraversal_i(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var stack = [TreeNode]()
        var node = root
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node!)
                ans.insert(node!.val, at: 0)
                node = node?.right
            }
            let top = stack.popLast()
            node = top!.left
        }
        return ans
    }
}

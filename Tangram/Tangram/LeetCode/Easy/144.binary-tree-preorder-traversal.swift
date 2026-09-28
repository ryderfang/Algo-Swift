/*
 * @lc app=leetcode id=144 lang=swift
 *
 * [144] Binary Tree Preorder Traversal
 */

// @lc code=start
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
extension Solution {
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
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

    func preorderTraversal1(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack: [TreeNode] = [root]
        while !stack.isEmpty {
            guard let node = stack.popLast() else { break }
            ans.append(node.val)
            if let right = node.right {
                stack.append(right)
            }
            // last in first out
            if let left = node.left {
                stack.append(left)
            }
        }
        return ans
    }

    // MARK: Recursive
    func preorderTraversal2(_ root: TreeNode?) -> [Int] {
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
}
// @lc code=end


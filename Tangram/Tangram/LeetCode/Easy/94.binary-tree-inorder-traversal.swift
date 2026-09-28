/*
 * @lc app=leetcode id=94 lang=swift
 *
 * [94] Binary Tree Inorder Traversal
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
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
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

    func inorderTraversal1(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var stack = [TreeNode]()
        var node = root
        while !stack.isEmpty || node != nil {
            if let tmp = node {
                stack.append(tmp)
                node = tmp.left
            } else {
                node = stack.popLast()
                ans.append(node!.val)
                node = node?.right
            }
        }
        return ans
    }

    // MARK: Recursive
    func inorderTraversal2(_ root: TreeNode?) -> [Int] {
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
}
// @lc code=end


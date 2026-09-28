/*
 * @lc app=leetcode id=112 lang=swift
 *
 * [112] Path Sum
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
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let node = root else { return false }
        if node.left == nil && node.right == nil {
            return node.val == targetSum
        }
        let newTarget = targetSum - node.val
        return hasPathSum(node.left, newTarget) || hasPathSum(node.right, newTarget)
    }
}
// @lc code=end


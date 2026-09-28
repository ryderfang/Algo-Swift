/*
 * @lc app=leetcode id=226 lang=swift
 *
 * [226] Invert Binary Tree
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
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let node = root else { return nil }
        let tmp = node.left
        node.left = invertTree(node.right)
        node.right = invertTree(tmp)
        return node
    }
}
// @lc code=end


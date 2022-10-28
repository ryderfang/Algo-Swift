/*
 * @lc app=leetcode id=110 lang=swift
 *
 * [110] Balanced Binary Tree
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
    func isBalanced(_ root: TreeNode?) -> Bool {
        func _height(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            return max(_height(node.left), _height(node.right)) + 1
        }
        guard let node = root else { return true }
        if !isBalanced(node.left) || !isBalanced(node.right) {
            return false
        }
        if abs(_height(node.left) - _height(node.right)) > 1 {
            return false
        }
        return true
    }
}
// @lc code=end


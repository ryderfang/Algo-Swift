/*
 * @lc app=leetcode id=111 lang=swift
 *
 * [111] Minimum Depth of Binary Tree
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
class Solution {
    func minDepth(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        if node.left == nil && node.right == nil {
            return 1
        }
        var minLeft = Int.max
        if let left = node.left {
            minLeft = minDepth(left)
        }
        var minRight = Int.max
        if let right = node.right {
            minRight = minDepth(right)
        }
        return min(minLeft, minRight) + 1
    }
}
// @lc code=end


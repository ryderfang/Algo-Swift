/*
 * @lc app=leetcode id=222 lang=swift
 *
 * [222] Count Complete Tree Nodes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
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
    func countNodes(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        return countNodes(root.left) + countNodes(root.right) + 1
    }
}
// @lc code=end


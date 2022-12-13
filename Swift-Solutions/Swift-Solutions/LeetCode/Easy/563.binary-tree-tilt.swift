/*
 * @lc app=leetcode id=563 lang=swift
 *
 * [563] Binary Tree Tilt
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
    func findTilt(_ root: TreeNode?) -> Int {
        var ans = 0
        @discardableResult
        func _sum(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            let left = _sum(root.left)
            let right = _sum(root.right)
            ans += abs(left - right)
            return left + right + root.val
        }
        _sum(root)
        return ans
    }
}
// @lc code=end


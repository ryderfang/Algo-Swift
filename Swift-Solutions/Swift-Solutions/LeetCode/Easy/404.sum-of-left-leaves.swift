/*
 * @lc app=leetcode id=404 lang=swift
 *
 * [404] Sum of Left Leaves
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
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        var ans = 0
        if let left = node.left {
            if left.left == nil && left.right == nil {
                ans += left.val
            }
        }
        ans += sumOfLeftLeaves(root?.left)
        ans += sumOfLeftLeaves(root?.right)
        return ans
    }
}
// @lc code=end


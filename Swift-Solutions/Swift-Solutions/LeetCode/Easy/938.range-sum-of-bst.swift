/*
 * @lc app=leetcode id=938 lang=swift
 *
 * [938] Range Sum of BST
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
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
        var ans = 0
        func _rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) {
            guard let node = root else { return }
            if node.val > high {
                _rangeSumBST(node.left, low, high)
            } else if node.val < low {
                _rangeSumBST(node.right, low, high)
            } else {
                ans += node.val
                _rangeSumBST(node.left, low, high)
                _rangeSumBST(node.right, low, high)
            }
        }
        _rangeSumBST(root, low, high)
        return ans
    }
}
// @lc code=end


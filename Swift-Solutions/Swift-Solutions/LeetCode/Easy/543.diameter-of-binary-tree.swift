/*
 * @lc app=leetcode id=543 lang=swift
 *
 * [543] Diameter of Binary Tree
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
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        @discardableResult
        func _length(_ root: TreeNode?, _ ans: inout Int) -> (left: Int, right: Int) {
            guard let root = root else { return (left: -1, right: -1) }
            let leftLength = _length(root.left, &ans)
            let rightLength = _length(root.right, &ans)
            let maxLeft = max(leftLength.left, leftLength.right) + 1
            let maxRight = max(rightLength.left, rightLength.right) + 1
            ans = max(ans, maxLeft + maxRight)
            return (left: maxLeft, right:maxRight)
        }
        var ans = 0
        _length(root, &ans)
        return ans
    }
}
// @lc code=end


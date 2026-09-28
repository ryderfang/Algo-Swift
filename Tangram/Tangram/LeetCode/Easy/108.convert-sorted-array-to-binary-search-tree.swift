/*
 * @lc app=leetcode id=108 lang=swift
 *
 * [108] Convert Sorted Array to Binary Search Tree
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
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else { return nil }
        let sz = nums.count
        if sz == 1 {
            return TreeNode(nums[0])
        }
        let mid: Int = (sz - 1) / 2
        let root = TreeNode(nums[mid])
        root.left = sortedArrayToBST(Array<Int>(nums[0..<mid]))
        root.right = sortedArrayToBST(Array<Int>(nums[mid+1..<sz]))
        return root
    }
}
// @lc code=end


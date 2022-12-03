/*
 * @lc app=leetcode id=113 lang=swift
 *
 * [113] Path Sum II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a binary tree node.
 * public extension TreeNode {
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
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        guard let node = root else { return [] }
        if node.val == targetSum && node.left == nil && node.right == nil {
            return [[node.val]]
        }
        var ans = [[Int]]()
        let left = pathSum(node.left, targetSum - node.val)
        if left.count > 0 {
            ans.append(contentsOf: left.map { [node.val] + $0 })
        }
        let right = pathSum(node.right, targetSum - node.val)
        if right.count > 0 {
            ans.append(contentsOf: right.map { [node.val] + $0 })
        }
        return ans
    }
}
// @lc code=end


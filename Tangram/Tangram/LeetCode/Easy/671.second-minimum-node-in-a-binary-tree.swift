/*
 * @lc app=leetcode id=671 lang=swift
 *
 * [671] Second Minimum Node In a Binary Tree
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
    func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }
        let rootVal = root.val
        var level = [root]
        var ans = Int.max
        while !level.isEmpty {
            guard level.count > 0 else { break }
            if let tmp = level.filter({ $0.val != rootVal }).map({ $0.val }).min() {
                ans = min(ans, tmp)
            }
            level = level
                .filter { $0.val == rootVal }
                .flatMap { [$0.left, $0.right] }
                .compactMap { $0 }
        }
        return ans == Int.max ? -1 : ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=199 lang=swift
 *
 * [199] Binary Tree Right Side View
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
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var stack = [root]
        var ans = [Int]()
        while !stack.isEmpty {
            if let last = stack.last {
                ans.append(last.val)
            }
            stack = stack.flatMap { [$0.left, $0.right] }.compactMap { $0 }
        }
        return ans
    }
}
// @lc code=end


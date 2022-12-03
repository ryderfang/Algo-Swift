/*
 * @lc app=leetcode id=107 lang=swift
 *
 * [107] Binary Tree Level Order Traversal II
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
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let node = root else { return [] }
        var queue = [TreeNode?]()
        queue.append(node)
        var ans = [[Int]](repeating: [Int](), count: 0)
        while !queue.isEmpty {
            var next = [TreeNode?]()
            var level = [Int]()
            while !queue.isEmpty {
                guard let last = queue.removeLast() else { continue }
                next.append(last.left)
                next.append(last.right)
                level.append(last.val)
            }
            if level.count > 0 {
                ans.append(level)
            }
            queue = next.reversed()
        }
        return Array(ans.reversed())
    }
}
// @lc code=end


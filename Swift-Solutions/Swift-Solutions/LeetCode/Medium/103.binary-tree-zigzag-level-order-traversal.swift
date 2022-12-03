/*
 * @lc app=leetcode id=103 lang=swift
 *
 * [103] Binary Tree Zigzag Level Order Traversal
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
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var ans = [[Int]]()
        var queue = [TreeNode?]()
        queue.append(root)
        var left = true
        while !queue.isEmpty {
            var next = [TreeNode?]()
            var tmp = [Int]()
            while !queue.isEmpty {
                guard let node = queue.removeLast() else { continue }
                if left {
                    next.append(contentsOf: [node.left, node.right])
                } else {
                    next.append(contentsOf: [node.right, node.left])
                }
                tmp.append(node.val)
            }
            if tmp.count > 0 {
                ans.append(tmp)
            }
            queue = next
            left = !left
        }
        return ans
    }
}
// @lc code=end


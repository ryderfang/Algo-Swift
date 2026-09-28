/*
 * @lc app=leetcode id=783 lang=swift
 *
 * [783] Minimum Distance Between BST Nodes
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
    func minDiffInBST(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }
        var stack = [TreeNode]()
        var node: TreeNode? = root
        var pre = Int.min, ans = Int.max
        while !stack.isEmpty || node != nil {
            while let tmp = node {
                stack.append(tmp)
                node = tmp.left
            }
            let top = stack.removeLast()
            if pre > Int.min {
                ans = min(ans, abs(top.val - pre))
                guard ans > 0 else { return 0 }
            }
            pre = top.val
            node = top.right
        }
        return ans
    }
}
// @lc code=end


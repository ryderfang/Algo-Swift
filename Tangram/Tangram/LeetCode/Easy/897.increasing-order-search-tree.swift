/*
 * @lc app=leetcode id=897 lang=swift
 *
 * [897] Increasing Order Search Tree
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
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        func _inOrder(_ node: TreeNode?, _ ans: inout TreeNode?) {
            guard let node = node else { return }
            _inOrder(node.left, &ans)
            let tmp = TreeNode(node.val)
            ans?.right = tmp
            ans = tmp
            _inOrder(node.right, &ans)
        }
        let ans = TreeNode(-1)
        var p: TreeNode? = ans
        _inOrder(root, &p)
        return ans.right
    }
}
// @lc code=end


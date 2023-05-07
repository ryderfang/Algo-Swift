/*
 * @lc app=leetcode id=230 lang=swift
 *
 * [230] Kth Smallest Element in a BST
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
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var inOrder = [Int]()
        func _inOrder(_ node: TreeNode?) {
            guard let node = node else { return }
            _inOrder(node.left)
            inOrder.append(node.val)
            _inOrder(node.right)
        }
        _inOrder(root)
        return inOrder[k-1]
    }
}
// @lc code=end


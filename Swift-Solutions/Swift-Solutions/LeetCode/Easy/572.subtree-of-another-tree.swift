/*
 * @lc app=leetcode id=572 lang=swift
 *
 * [572] Subtree of Another Tree
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
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        func _isSameTree(_ node1: TreeNode?, _ node2: TreeNode?) -> Bool {
            if node1 == nil && node2 == nil {
                return true
            }
            guard node1?.val == node2?.val else { return false }
            return _isSameTree(node1?.left, node2?.left) && _isSameTree(node1?.right, node2?.right)
        }

        if root == nil && subRoot == nil {
            return true
        }
        guard let root = root else { return false }
        guard !_isSameTree(root, subRoot) else { return true }
        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
    }
}
// @lc code=end


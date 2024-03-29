/*
 * @lc app=leetcode id=100 lang=swift
 *
 * [100] Same Tree
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
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        let vp = p?.val, vq = q?.val
        if vp == nil && vq == nil {
            return true
        }
        if vp == vq {
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
        return false
    }
}

// @lc code=end


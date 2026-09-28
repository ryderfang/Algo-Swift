/*
 * @lc app=leetcode id=653 lang=swift
 *
 * [653] Two Sum IV - Input is a BST
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
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        var ans = [Int]()
        func _inorder(_ root: TreeNode?) {
            guard let root = root else { return }
            _inorder(root.left)
            ans.append(root.val)
            _inorder(root.right)
        }
        _inorder(root)
        let n = ans.count
        var l = 0, r = n - 1
        while l < r {
            while l > 0 && l < r && ans[l] == ans[l-1] {
                l += 1
            }
            while r < n - 2 && l < r && ans[r] == ans[r+1] {
                r -= 1
            }
            let sum = ans[l] + ans[r]
            if sum == k {
                return true
            }
            if sum < k {
                l += 1
            } else {
                r -= 1
            }
        }
        return false
    }
}
// @lc code=end


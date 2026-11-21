/*
 * @lc app=leetcode id=1022 lang=swift
 *
 * [1022] Sum of Root To Leaf Binary Numbers
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
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        var ret = 0
        func _sumToCurrent(_ node: TreeNode?, _ tmp: Int = 0) {
            guard let val = node?.val else { return }
            let tmp = tmp << 1 + val
            // leaf
            if node?.left == nil && node?.right == nil {
                ret += tmp
            }
            _sumToCurrent(node?.left, tmp)
            _sumToCurrent(node?.right, tmp)
        }
        _sumToCurrent(root, 0)
        return ret
    }
}
// @lc code=end

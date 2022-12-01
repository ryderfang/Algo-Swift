/*
 * @lc app=leetcode id=98 lang=swift
 *
 * [98] Validate Binary Search Tree
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
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard root != nil else { return false }
        var list = [Int]()
        func _inorder(_ node: TreeNode?, _ res: inout [Int]) {
            guard let node = node else { return }
            _inorder(node.left, &res)
            res.append(node.val)
            _inorder(node.right, &res)
        }
        _inorder(root, &list)
        var last = list[0]
        for x in list.dropFirst() {
            guard last < x else { return false }
            last = x
        }
        return true
    }
}
// @lc code=end


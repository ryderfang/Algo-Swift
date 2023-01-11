/*
 * @lc app=leetcode id=965 lang=swift
 *
 * [965] Univalued Binary Tree
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
    func isUnivalTree(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        let uniVal = root.val
        var stack: [TreeNode?] = [root.left, root.right]
        while !stack.isEmpty {
            let top = stack.removeLast()
            if let top = top {
                guard top.val == uniVal else { return false }
            }
            stack.append(contentsOf: [top?.right, top?.left].compactMap({ $0 }))
        }
        return true
    }
}
// @lc code=end


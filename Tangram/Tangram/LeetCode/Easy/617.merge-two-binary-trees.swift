/*
 * @lc app=leetcode id=617 lang=swift
 *
 * [617] Merge Two Binary Trees
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
    func mergeTrees2(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil && root2 == nil {
            return nil
        }
        if root1 != nil && root2 == nil {
            return root1
        }
        if root1 == nil && root2 != nil {
            return root2
        }
        let root = TreeNode((root1?.val ?? 0) + (root2?.val ?? 0))
        root.left = mergeTrees(root1?.left, root2?.left)
        root.right = mergeTrees(root1?.right, root2?.right)
        return root
    }

    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        switch (root1, root2) {
        case (.some(let root1), .some(let root2)):
            let root = TreeNode(root1.val + root2.val)
            root.left = mergeTrees(root1.left, root2.left)
            root.right = mergeTrees(root1.right, root2.right)
            return root
        case (.some(let node1), .none):
            return node1
        case (.none, .some(let node2)):
            return node2
        case (.none, .none):
            return nil
        }
    }
}
// @lc code=end


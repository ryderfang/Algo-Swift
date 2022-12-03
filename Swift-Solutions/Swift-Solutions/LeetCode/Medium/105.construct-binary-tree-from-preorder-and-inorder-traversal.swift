/*
 * @lc app=leetcode id=105 lang=swift
 *
 * [105] Construct Binary Tree from Preorder and Inorder Traversal
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
    // 前序 + 中序 -> 建树
    // 根左右 + 左根右
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        return buildTree(pre: preorder, inorder)
    }

    func buildTree(pre preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        let n = preorder.count
        guard n > 0 else { return nil }
        let root = TreeNode(preorder[0])
        guard let rootIdx = inorder.firstIndex(of: root.val) else { return nil }
        if rootIdx > 0 {
            root.left = buildTree(pre: Array(preorder[1...rootIdx]), Array(inorder[0..<rootIdx]))
        }
        root.right = buildTree(pre: Array(preorder[rootIdx+1..<n]), Array(inorder[rootIdx+1..<n]))
        return root
    }
}
// @lc code=end


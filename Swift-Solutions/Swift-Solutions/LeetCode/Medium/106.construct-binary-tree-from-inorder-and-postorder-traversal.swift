/*
 * @lc app=leetcode id=106 lang=swift
 *
 * [106] Construct Binary Tree from Inorder and Postorder Traversal
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
    // 中序 + 后序 -> 建树
    // 左根右 + 左右根
//    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
//        return buildTree(inorder, post: postorder)
//    }

    func buildTree(_ inorder: [Int], post postorder: [Int]) -> TreeNode? {
        let n = inorder.count
        guard n > 0 else { return nil }
        let root = TreeNode(postorder[n-1])
        guard let rootIdx = inorder.firstIndex(of: root.val) else { return nil }
        if rootIdx > 0 {
            root.left = buildTree(Array(inorder[0..<rootIdx]), post: Array(postorder[0..<rootIdx]))
        }
        root.right = buildTree(Array(inorder[rootIdx+1..<n]), post: Array(postorder[rootIdx..<n-1]))
        return root
    }
}
// @lc code=end


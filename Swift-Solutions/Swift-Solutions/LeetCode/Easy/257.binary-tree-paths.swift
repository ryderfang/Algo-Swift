/*
 * @lc app=leetcode id=257 lang=swift
 *
 * [257] Binary Tree Paths
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
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        guard let node = root else { return [] }
        // leaf
        if node.left == nil && node.right == nil {
            return ["\(node.val)"]
        }
        var ans = [String]()
        let leftPaths = binaryTreePaths(node.left)
        if leftPaths.count > 0 {
            ans.append(contentsOf: leftPaths.map { return "\(node.val)->" + $0 } )
        }
        let rightPath = binaryTreePaths(node.right)
        if rightPath.count > 0 {
            ans.append(contentsOf: rightPath.map { "\(node.val)->" + $0 } )
        }
        return ans
    }
}
// @lc code=end


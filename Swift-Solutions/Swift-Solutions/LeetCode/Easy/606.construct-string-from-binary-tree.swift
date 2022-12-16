/*
 * @lc app=leetcode id=606 lang=swift
 *
 * [606] Construct String from Binary Tree
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
    func tree2str(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }
        var stack: [Any] = [root]
        var ans = ""
        while !stack.isEmpty {
            let top = stack.removeLast()
            if let node = top as? TreeNode {
                ans += "\(node.val)"
                var hasRight = false
                if let right = node.right {
                    hasRight = true
                    stack.append(")")
                    stack.append(right)
                    stack.append("(")
                }
                if let left = node.left {
                    stack.append(")")
                    stack.append(left)
                    stack.append("(")
                } else if hasRight {
                    stack.append("()")
                }
            } else if let parenthesis = top as? String {
                ans += parenthesis
            }
        }
        return ans
    }

    func tree2str1(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }
        let left = tree2str(root.left)
        let right = tree2str(root.right)
        var ans = "\(root.val)"
        if left.count > 0 {
            ans += "(\(left))"
        } else if right.count > 0 {
            ans += "()"
        }
        if right.count > 0 {
            ans += "(\(right))"
        }
        return ans
    }
}
// @lc code=end


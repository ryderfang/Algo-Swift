/*
 * @lc app=leetcode id=872 lang=swift
 *
 * [872] Leaf-Similar Trees
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
    func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        func _leafs(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            var ret = [Int]()
            var stack = [node]
            while !stack.isEmpty {
                let top = stack.removeLast()
                if top.left == nil && top.right == nil {
                    ret.append(top.val)
                }
                if let right = top.right {
                    stack.append(right)
                }
                if let left = top.left {
                    stack.append(left)
                }
            }
            return ret
        }
        let leaf1 = _leafs(root1)
        let leaf2 = _leafs(root2)
        guard leaf1.count == leaf2.count else { return false}
        for i in 0..<leaf1.count {
            guard leaf1[i] == leaf2[i] else { return false }
        }
        return true
    }
}
// @lc code=end


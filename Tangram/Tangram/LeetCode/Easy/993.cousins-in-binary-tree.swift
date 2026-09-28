/*
 * @lc app=leetcode id=993 lang=swift
 *
 * [993] Cousins in Binary Tree
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
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else { return false }
        var stack: [TreeNode] = [root]
        guard root.val != x && root.val != y else { return false }
        while !stack.isEmpty {
            var next = [TreeNode]()
            var (xi, yi) = (-1, -1)
            for i in 0..<stack.count {
                if let left = stack[i].left {
                    next.append(left)
                    if left.val == x {
                        xi = i
                    }
                    if left.val == y {
                        yi = i
                    }
                }
                if let right = stack[i].right {
                    next.append(right)
                    if right.val == x {
                        xi = i
                    }
                    if right.val == y {
                        yi = i
                    }
                }
            }
            if (xi >= 0 && yi < 0) || (xi < 0 && yi >= 0) {
                return false
            }
            if xi >= 0 && yi >= 0 {
                return xi != yi
            }
            stack = next
        }
        return false
    }
}
// @lc code=end


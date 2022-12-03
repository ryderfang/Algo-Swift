/*
 * @lc app=leetcode id=114 lang=swift
 *
 * [114] Flatten Binary Tree to Linked List
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
    func flatten(_ root: TreeNode?) {
        func _preOrder(_ root: TreeNode?) -> (head: TreeNode?, tail: TreeNode?) {
            guard let node = root else { return (head: nil, tail: nil) }
            let head = node
            var tail: TreeNode? = head
            let (leftHead, leftTail) = _preOrder(head.left)
            let (rightHead, rightTail) = _preOrder(head.right)
            head.left = nil
            head.right = leftHead != nil ? leftHead : rightHead
            leftTail?.left = nil
            leftTail?.right = rightHead
            rightTail?.left = nil
            tail = rightTail != nil ? rightTail : (leftTail != nil ? leftTail : head)
            return (head: head, tail: tail)
        }
        _ = _preOrder(root)
    }
}
// @lc code=end


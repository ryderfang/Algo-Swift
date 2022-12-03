/*
 * @lc app=leetcode id=109 lang=swift
 *
 * [109] Convert Sorted List to Binary Search Tree
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
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
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        guard let head = head else { return nil }
        var nodes = [ListNode]()
        var node: ListNode? = head
        while node != nil {
            guard let tmp = node else { break }
            nodes.append(tmp)
            node = tmp.next
        }
        func _listToBST(_ nodes: [ListNode]) -> TreeNode? {
            let n = nodes.count
            guard n > 0 else { return nil }
            guard n > 1 else { return TreeNode(nodes[0].val) }
            let mid = n / 2
            let root = TreeNode(nodes[mid].val)
            root.left = _listToBST(Array(nodes[0..<mid]))
            root.right = _listToBST(Array(nodes[mid+1..<n]))
            return root
        }
        return _listToBST(nodes)
    }
}
// @lc code=end


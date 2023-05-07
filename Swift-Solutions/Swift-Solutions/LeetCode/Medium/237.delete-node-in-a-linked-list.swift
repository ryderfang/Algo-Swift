/*
 * @lc app=leetcode id=237 lang=swift
 *
 * [237] Delete Node in a Linked List
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
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */

extension Solution {
    // 本来以为不可能，后来想到可以替换节点内的值
    func deleteNode(_ node: ListNode?) {
        var p = node, q = node?.next
        while p != nil && q != nil {
            p!.val = q!.val
            if q?.next == nil {
                p?.next = nil
                break
            }
            p = q
            q = q?.next
        }
    }
    // better solution
    func deleteNode1(_ node: ListNode?) {
        node?.val = node?.next?.val ?? 0
        node?.next = node?.next?.next
    }
}
// @lc code=end


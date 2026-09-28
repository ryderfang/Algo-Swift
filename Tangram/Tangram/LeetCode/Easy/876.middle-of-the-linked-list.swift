/*
 * @lc app=leetcode id=876 lang=swift
 *
 * [876] Middle of the Linked List
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
extension Solution {
    // two-pointers
    func middleNode(_ head: ListNode?) -> ListNode? {
        var p = head, q = head
        while q?.next != nil {
            p = p?.next
            q = q?.next?.next
        }
        return p
    }
}
// @lc code=end


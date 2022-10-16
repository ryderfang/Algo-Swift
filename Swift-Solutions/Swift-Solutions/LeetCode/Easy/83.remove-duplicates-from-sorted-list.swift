/*
 * @lc app=leetcode id=83 lang=swift
 *
 * [83] Remove Duplicates from Sorted List
 */

// @lc code=start
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
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard head != nil else { return nil }
        var p = head
        while p?.next != nil {
            var q = p?.next
            var r = p
            while q != nil && q?.val == r?.val {
                r = q
                q = q?.next
            }
            p?.next = q
            p = q
        }
        return head
    }
}
// @lc code=end


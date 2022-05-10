/*
 * @lc app=leetcode id=19 lang=swift
 *
 * [19] Remove Nth Node From End of List
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
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var p : ListNode? = head
        var q : ListNode? = head
        var dis = 0
        while q?.next != nil {
            if dis < n {
                q = q?.next
                dis += 1
            } else {
                p = p?.next
                q = q?.next
            }
        }
        if dis < n {
            // remove head
            return head?.next
        } else {
            p?.next = p?.next?.next ?? nil
            return head
        }
    }
}

// @lc code=end


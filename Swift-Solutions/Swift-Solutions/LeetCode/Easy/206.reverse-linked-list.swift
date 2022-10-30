/*
 * @lc app=leetcode id=206 lang=swift
 *
 * [206] Reverse Linked List
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
    func reverseList(_ head: ListNode?) -> ListNode? {
        var ans = head?.next
        var p = head
        p?.next = nil
        while ans != nil {
            let tmp = ans?.next
            ans?.next = p
            p = ans
            ans = tmp
        }
        return p
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=203 lang=swift
 *
 * [203] Remove Linked List Elements
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
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let ans = ListNode()
        ans.next = head
        var pp: ListNode? = ans
        var p = head
        while p != nil {
            if p?.val == val {
                pp?.next = p?.next
            } else {
                pp = p
            }
            p = p?.next
        }
        return ans.next
    }
}
// @lc code=end


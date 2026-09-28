/*
 * @lc app=leetcode id=328 lang=swift
 *
 * [328] Odd Even Linked List
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
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        var p1 = head
        var p2 = head?.next
        var oddtail = p1
        let evenHead = p2
        while p1 != nil {
            oddtail = p1
            p1?.next = p2?.next
            p2?.next = p2?.next?.next
            if p1?.next != nil {
                oddtail = p1?.next
            }
            p1 = p1?.next
            p2 = p2?.next
        }
        oddtail?.next = evenHead
        return head
    }
}
// @lc code=end


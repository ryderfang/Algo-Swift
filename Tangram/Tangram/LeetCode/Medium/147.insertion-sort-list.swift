/*
 * @lc app=leetcode id=147 lang=swift
 *
 * [147] Insertion Sort List
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
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        var head = head
        var q = head
        while let next = q?.next {
            let key = next.val
            var pre: ListNode? = nil
            var p = head
            while let now = p, p !== next, now.val < key {
                pre = p
                p = p?.next
            }
            if p === next {
                // next is the largest
                q = next
            } else {
                // insert next between "pre" and "p"
                q?.next = next.next
                next.next = p
                if pre == nil {
                    head = next
                } else {
                    pre?.next = next
                }
            }
        }
        return head
    }
}
// @lc code=end


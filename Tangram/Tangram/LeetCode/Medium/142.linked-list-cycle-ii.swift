/*
 * @lc app=leetcode id=142 lang=swift
 *
 * [142] Linked List Cycle II
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
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var fast = head, slow = head
        while fast != nil && slow != nil {
            fast = fast?.next
            slow = slow?.next?.next
            if fast === slow {
                break
            }
        }
        // no cycle
        if fast == nil || slow == nil {
            return nil
        }
        var p = head
        while p !== fast {
            p = p?.next
            fast = fast?.next
        }
        return p
    }
}

// @lc code=end

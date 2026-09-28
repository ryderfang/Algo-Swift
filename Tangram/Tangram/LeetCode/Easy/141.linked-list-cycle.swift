/*
 * @lc app=leetcode id=141 lang=swift
 *
 * [141] Linked List Cycle
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
    // two-pointers
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head?.next?.next
        while slow != nil && fast != nil {
            guard slow !== fast else { return true }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
}
// @lc code=end


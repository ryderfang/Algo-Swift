/*
 * @lc app=leetcode id=2 lang=swift
 *
 * [2] Add Two Numbers
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
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var p = l1
        var q = l2
        var c = 0
        var ans : ListNode? = nil
        var r : ListNode? = nil
        while c != 0 || p != nil || q != nil {
            var sum = c
            sum += p?.val ?? 0
            p = p?.next ?? nil
            sum += q?.val ?? 0
            q = q?.next ?? nil
            let node = ListNode(sum % 10)
            if ans == nil {
                ans = node
            } else {
                r?.next = node
            }
            r = node
            c = sum / 10
        }
        return ans
    }
}

// @lc code=end

/*
 * @lc app=leetcode id=21 lang=swift
 *
 * [21] Merge Two Sorted Lists
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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if let head1 = list1, let head2 = list2 {
            if head1.val < head2.val {
                head1.next = mergeTwoLists(list1?.next, list2)
                return head1
            } else {
                head2.next = mergeTwoLists(list1, list2?.next)
                return head2
            }
        } else {
            return list1 ?? list2
        }
    }

    func mergeTwoLists1(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        let ans = ListNode(0)
        var p = list1
        var q = list2
        var r : ListNode? = ans
        while p != nil && q != nil {
            if p!.val <= q!.val {
                r?.next = p
                r = p
                p = p!.next
            } else {
                r?.next = q
                r = q
                q = q!.next
            }
        }
        if p != nil {
            r?.next = p
        } else if q != nil {
            r?.next = q
        }
        return ans.next
    }
}
// @lc code=end


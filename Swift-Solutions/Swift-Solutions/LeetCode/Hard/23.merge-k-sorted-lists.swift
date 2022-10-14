/*
 * @lc app=leetcode id=23 lang=swift
 *
 * [23] Merge k Sorted Lists
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
class Solution {
    func mergeTwo(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if let head1 = list1, let head2 = list2 {
            if head1.val < head2.val {
                head1.next = mergeTwo(list1?.next, list2)
                return head1
            } else {
                head2.next = mergeTwo(list1, list2?.next)
                return head2
            }
        } else {
            return list1 ?? list2
        }
    }

    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard lists.count > 0 else { return nil }
        guard lists.count > 1 else { return lists.first ?? nil }
        var ret: ListNode? = lists.first ?? nil
        for l in lists.dropFirst() {
            ret = mergeTwo(ret, l)
        }
        return ret
    }
}
// @lc code=end


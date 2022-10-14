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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard lists.count > 0 else { return nil }
        var nums: [Int] = []
        for var l in lists {
            while l != nil {
                nums.append(l!.val)
                l = l?.next
            }
        }
        var p: ListNode? = ListNode()
        let ans = p
        for a in nums.sorted() {
            p?.next = ListNode(a)
            p = p?.next
        }
        return ans
    }
}
// @lc code=end


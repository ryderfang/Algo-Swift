/*
 * @lc app=leetcode id=86 lang=swift
 *
 * [86] Partition List
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for singly-linked list.
 * public extension ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
extension Solution {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        guard let node = head else { return nil }
        var left: ListNode? = nil
        var right: ListNode? = nil
        var pLeft = left
        var pRight = right
        var p: ListNode? = node
        while p != nil {
            if p!.val < x {
                if left == nil {
                    left = p
                    pLeft = left
                } else {
                    pLeft?.next = p
                    pLeft = p
                }
            } else {
                if right == nil {
                    right = p
                    pRight = right
                } else {
                    pRight?.next = p
                    pRight = p
                }
            }
            p = p?.next
        }
        pRight?.next = nil
        if left == nil {
            return right
        } else {
            pLeft?.next = right
            return left
        }
    }
}
// @lc code=end


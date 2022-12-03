/*
 * @lc app=leetcode id=61 lang=swift
 *
 * [61] Rotate List
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
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard k > 0 else { return head }
        guard let head = head else { return nil }
        var n = 1
        var tail = head
        while let t = tail.next {
            n += 1
            tail = t
        }
        if k % n == 0 {
            return head
        }
        let x = n - k % n - 1
        var count = 0
        var pre: ListNode? = head
        while pre != nil {
            if count == x {
                break
            }
            pre = pre?.next
            count += 1
        }
        tail.next = head
        let ans = pre?.next
        pre?.next = nil
        return ans
    }
}
// @lc code=end


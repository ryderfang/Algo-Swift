/*
 * @lc app=leetcode id=24 lang=swift
 *
 * [24] Swap Nodes in Pairs
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
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard let node = head else { return nil }
        guard let next = node.next else { return node }
        let nnext = next.next
        next.next = node
        node.next = swapPairs(nnext)
        return next
    }
}
// @lc code=end


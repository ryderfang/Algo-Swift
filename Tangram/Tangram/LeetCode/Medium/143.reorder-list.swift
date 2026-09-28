/*
 * @lc app=leetcode id=143 lang=swift
 *
 * [143] Reorder List
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
    func reorderList(_ head: ListNode?) {
        guard let head = head else { return }
        var lists = [ListNode]()
        var p: ListNode? = head
        while p != nil {
            lists.append(p!)
            p = p?.next
        }
        p = head
        var q = lists.removeLast()
        while p !== q {
            let t = p?.next
            p?.next = q
            q.next = t
            p = t
            if p === q {
                break
            }
            q = lists.removeLast()
        }
        q.next = nil
    }
}
// @lc code=end


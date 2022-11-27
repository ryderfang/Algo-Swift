/*
 * @lc app=leetcode id=82 lang=swift
 *
 * [82] Remove Duplicates from Sorted List II
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
//    fileprivate
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard let node = head else { return nil }
        let ans = ListNode()
        var q: ListNode? = ans
        var p: ListNode? = node
        while p != nil {
            if let r = p?.next {
                if r.val != p?.val {
                    q?.next = p
                    q = p
                    p = r
                    continue
                }
                p = r
                while p?.next != nil && p?.next?.val == p?.val {
                    p = p?.next
                }
                p = p?.next
                if p == nil {
                    q?.next = p
                    break
                }
            } else {
                q?.next = p
                break
            }
        }
        return ans.next
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=92 lang=swift
 *
 * [92] Reverse Linked List II
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
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        guard let node = head else { return nil }
        guard left < right else { return node }
        var i = 1
        let ans = ListNode()
        ans.next = node
        var p: ListNode? = ans
        var q: ListNode? = nil
        var leftNode: ListNode? = node
        var rightNode: ListNode? = node
        while i <= right {
            if i < left {
                p = leftNode
                leftNode = leftNode?.next
            }
            if i < right {
                rightNode = rightNode?.next
            } else {
                q = rightNode?.next
            }
            i += 1
        }
        // p.next = leftNode
        // rightNode.next = q
        rightNode?.next = nil
        // @return rightNode
        func _reverse(_ head: ListNode?) -> ListNode? {
            var p: ListNode? = nil
            var q = head
            while q != nil {
                let next = q?.next
                q?.next = p
                p = q
                q = next
            }
            return p
        }
        p?.next = _reverse(leftNode)
        leftNode?.next = q
        return ans.next
    }
}
// @lc code=end


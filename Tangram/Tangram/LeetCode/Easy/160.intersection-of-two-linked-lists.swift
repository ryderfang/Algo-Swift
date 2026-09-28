/*
 * @lc app=leetcode id=160 lang=swift
 *
 * [160] Intersection of Two Linked Lists
 */

// @lc code=start
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
extension Solution {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        guard let headA = headA, let headB = headB else { return nil }
        var stackA: [ListNode] = []
        var stackB: [ListNode] = []
        var pA: ListNode? = headA
        while pA != nil {
            stackA.append(pA!)
            pA = pA!.next
        }
        var pB: ListNode? = headB
        while pB != nil {
            stackB.append(pB!)
            pB = pB!.next
        }
        var ans: ListNode? = nil
        while !stackA.isEmpty && !stackB.isEmpty {
            if ObjectIdentifier(stackA.last!) == ObjectIdentifier(stackB.last!) {
                ans = stackA.removeLast()
                stackB.removeLast()
            } else {
                break
            }
        }
        return ans
    }
}
// @lc code=end


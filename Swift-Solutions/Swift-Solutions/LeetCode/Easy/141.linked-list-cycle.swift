/*
 * @lc app=leetcode id=141 lang=swift
 *
 * [141] Linked List Cycle
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

 extension ListNode: Equatable {
     fileprivate static func getObjectAddress(object: AnyObject) -> String {
         let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
         return String(describing: str)
     }

     public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
//         return getObjectAddress(object: lhs) == getObjectAddress(object: rhs)
         return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
     }
 }

class Solution {
    // two-pointers
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head?.next?.next
        while slow != nil && fast != nil {
            guard slow != fast else { return true }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
}
// @lc code=end


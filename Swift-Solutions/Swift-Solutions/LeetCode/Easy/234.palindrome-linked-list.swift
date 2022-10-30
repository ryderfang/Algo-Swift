/*
 * @lc app=leetcode id=234 lang=swift
 *
 * [234] Palindrome Linked List
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
extension Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var a: [Int8] = [Int8]()
        var p = head
        while p != nil {
            a.append(Int8(p!.val))
            p = p?.next
        }
        return a == a.reversed()
    }
}
// @lc code=end


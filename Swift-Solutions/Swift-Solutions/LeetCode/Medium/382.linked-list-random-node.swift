/*
 * @lc app=leetcode id=382 lang=swift
 *
 * [382] Linked List Random Node
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {
    var arr: [Int] = []
}
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

// * What if the linked list is extremely large and its length is unknown to you?

// * Could you solve this efficiently without using extra space?
// 
extension Solution {
    convenience init(_ head: ListNode?) {
        self.init()
        var p = head
        while p != nil {
            arr.append(p!.val)
            p = p!.next
        }
    }
    
    func getRandom() -> Int {
        let i = Int.random(in: 0..<arr.count)
        return arr[i]

        // reservoir sampling
//        var i: Int = 0
//        var val: Int?
//        var node: ListNode? = self.head
//        while(node !== nil) {
//            i += 1
//            if Int.random(in: 1...i) == i {
//                val = node!.val
//            }
//            node = node!.next
//        }
//        return val!
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(head)
 * let ret_1: Int = obj.getRandom()
 */
// @lc code=end


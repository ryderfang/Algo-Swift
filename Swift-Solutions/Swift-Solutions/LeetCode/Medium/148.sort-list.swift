/*
 * @lc app=leetcode id=148 lang=swift
 *
 * [148] Sort List
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
    func sortList(_ head: ListNode?) -> ListNode? {
        var n = 0
        var p = head
        while p != nil {
            n += 1
            p = p?.next
        }
        func _mergeSort(_ head: ListNode?, _ n: Int) -> ListNode? {
            guard n > 1 else { return head }
            let half = n / 2
            var count = 0
            var mid: ListNode? = head
            while count < half {
                count += 1
                let next = mid?.next
                mid = next
            }
            let left = _mergeSort(head, half)
            let right = _mergeSort(mid, n - half)
            return _merge(left, half, right, n - half)
        }

        func _merge(_ left: ListNode?, _ leftEnd: Int, _ right: ListNode?, _ rightEnd: Int) -> ListNode? {
            let head = ListNode(0)
            var r: ListNode? = head
            var p = left, leftIndex = 0
            var q = right, rightIndex = 0
            while leftIndex < leftEnd && rightIndex < rightEnd {
                if p!.val < q!.val {
                    r?.next = p
                    p = p?.next
                    leftIndex += 1
                } else {
                    r?.next = q
                    q = q?.next
                    rightIndex += 1
                }
                r = r?.next
            }
            while leftIndex < leftEnd {
                r?.next = p
                p = p?.next
                leftIndex += 1
                r = r?.next
            }
            while rightIndex < rightEnd {
                r?.next = q
                q = q?.next
                rightIndex += 1
                r = r?.next
            }
            r?.next = nil
            return head.next
        }
        return _mergeSort(head, n)
    }
}
// @lc code=end


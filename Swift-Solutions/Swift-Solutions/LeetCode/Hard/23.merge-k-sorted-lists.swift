/*
 * @lc app=leetcode id=23 lang=swift
 *
 * [23] Merge k Sorted Lists
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
    func mergeTwo(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let ans = ListNode(0)
        var r : ListNode? = ans
        var p = list1
        var q = list2
        while p != nil && q != nil {
            if p!.val <= q!.val {
                r?.next = p
                r = p
                p = p!.next
            } else {
                r?.next = q
                r = q
                q = q!.next
            }
        }
        if p != nil {
            r?.next = p
        } else if q != nil {
            r?.next = q
        }
        return ans.next
    }

    // 分治 O(N*logk)
    // level - logk
    // each level - O(N) = pairs * N / pairs
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        let sz = lists.count
        guard sz > 0 else { return nil }
        var interval = 1
        var tmp = lists
        while interval < sz {
            for i in stride(from: 0, to: sz - interval, by: interval * 2) {
                tmp[i] = mergeTwo(tmp[i], tmp[i + interval])
            }
            interval *= 2
        }
        return tmp[0]
    }

    // 暴力 O(N*k) - TLE
    // 2 * N / k + 3 * N / k + ... + k * N / k
    func mergeKLists_NA(_ lists: [ListNode?]) -> ListNode? {
        let sz = lists.count
        guard sz > 0 else { return nil }
        var ans: ListNode? = lists[0]
        for l in lists.dropFirst() {
            ans = mergeTwo(ans, l)
        }
        return ans
    }

    // 暴力排序 O(N*logN)
    func mergeKLists1(_ lists: [ListNode?]) -> ListNode? {
        guard lists.count > 0 else { return nil }
        var nums: [Int] = []
        for var l in lists {
            while l != nil {
                nums.append(l!.val)
                l = l?.next
            }
        }
        var p: ListNode? = ListNode()
        let ans = p
        for a in nums.sorted() {
            p?.next = ListNode(a)
            p = p?.next
        }
        return ans
    }
}
// @lc code=end


//
//  ListNode.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int = 0, _ next: ListNode? = nil) {
        self.val = val;
        self.next = next;
    }
}

public extension ListNode {
    func array() -> [Int] {
        var p: ListNode? = self
        var ans = [Int]()
        while p != nil {
            ans.append(p!.val)
            p = p!.next
        }
        return ans
    }

    // MARK: static
    static func arrayToList(_ nums: [Int]) -> ListNode? {
        guard nums.count > 0 else { return nil }
        let head = ListNode(nums[0])
        var p: ListNode = head
        for x in nums.dropFirst() {
            let q = ListNode(x)
            p.next = q
            p = q
        }
        return head
    }
}

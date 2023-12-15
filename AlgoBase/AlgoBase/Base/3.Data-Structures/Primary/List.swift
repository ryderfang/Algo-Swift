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
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

public extension ListNode {
    // should not have cycle
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

public extension ListNode {
    func tail() -> ListNode? {
        var node: ListNode? = self
        while node?.next != nil {
            node = node?.next
        }
        return node
    }

    // skip k steps
    func skip(_ k: Int = 1) -> ListNode? {
        var node: ListNode? = self
        for _ in 0..<k {
            guard node?.next != nil else { return nil }
            node = node?.next
        }
        return node
    }
}

// MARK: Equatable
extension ListNode/*: Equatable*/ {
    // List may has circles so have to compare pointer address.
//    fileprivate static func getObjectAddress(object: AnyObject) -> String {
//        let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
//        return String(describing: str)
//    }

    // fileprivate
    private static func == (lhs: ListNode, rhs: ListNode) -> Bool {
//        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
        return lhs !== rhs
    }
}

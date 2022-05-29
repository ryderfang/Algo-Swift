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
    public init() {
        self.val = 0;
        self.next = nil;
    }
    public init(_ val: Int) {
        self.val = val;
        self.next = nil;
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next;
    }
    
    public static func arrayToList(_ array: Array<Int>) -> ListNode? {
        var head : ListNode?  = nil
        if array.count == 0 {
            return nil
        } else {
            head = ListNode(array[0])
        }
        var p : ListNode? = head
        for item in array[1...] {
            let q = ListNode(item)
            p!.next = q
            p = q
        }
        return head
    }
    
    public func listToArray() -> Array<Int> {
        var p : ListNode? = self
        var ans = [Int]()
        while p != nil {
            ans.append(p!.val)
            p = p!.next
        }
        return ans
    }
}

//
//  Stack.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

// Push: O(1)
// Pop: O(1)
struct stack<Element> {
    fileprivate var items: [Element] = []
    mutating func push(_ val: Element) {
        items.append(val)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    func top() -> Element? {
        return items.last
    }
    func empty() -> Bool {
        return size() == 0
    }
    func size() -> Int {
        return items.count
    }
}

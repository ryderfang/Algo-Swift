//
//  Stack.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

struct stack<Element> {
    var items: [Element] = []
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

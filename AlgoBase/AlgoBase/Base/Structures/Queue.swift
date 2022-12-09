//
//  Queue.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

// MARK: Queue
fileprivate struct Queue<T> {
    private var array: [T] = []

    public var count: Int {
        return array.count
    }

    public var isEmpty: Bool {
        return array.isEmpty
    }

    // O(1)
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    // O(n)
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }

    public var front: T? {
        return array.first
    }
}

// MARK: LinkedQueue
fileprivate struct LinkedQueue<T> {
    private var head: Node? = nil
    private var tail: Node? = nil

    public var count: Int {
        guard var node = head else { return 0 }
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }

    public var isEmpty: Bool {
        return head == nil
    }

    // O(1)
    public mutating func enqueue(_ element: T) {
        let newNode = Node(value: element)
        if let lastNode = tail {
            newNode.previous = lastNode
            lastNode.next = newNode
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }

    // O(1)
    public mutating func dequeue() -> T? {
        guard let front = front else { return nil }
        if head === tail {
            head = nil
            tail = nil
        } else {
            head = head?.next
        }
        return front
    }

    public var front: T? {
        return head?.value
    }
}

extension LinkedQueue {
    private typealias Node = LinkedNode<T>

    private class LinkedNode<T> {
        var value: T
        var next: LinkedNode?
        weak var previous: LinkedNode?
        init(value: T) {
            self.value = value
            self.next = nil
            self.previous = nil
        }
    }

    func array() -> [T] {
        var array = [T]()
        guard var node = head else { return [] }
        array.append(node.value)
        while let next = node.next {
            array.append(next.value)
            node = next
        }
        return array
    }
}

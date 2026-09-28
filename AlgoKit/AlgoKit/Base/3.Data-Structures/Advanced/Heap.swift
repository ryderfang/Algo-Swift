//
//  Heap.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/4.
//

import Foundation

internal struct Heap<T> {
    var nodes = [T]()

    // compare: '>' for max-heap
    private var orderCriteria: (T, T) -> Bool

    public init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }

    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }

    private mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
            shiftDown(i)
        }
    }

    public var isEmpty: Bool {
        return nodes.isEmpty
    }

    public var count: Int {
        return nodes.count
    }

    public func peek() -> T? {
        return nodes.first
    }

    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }

    /**
     * Removes the root node from the heap. For a max-heap, this is the maximum
     * value; for a min-heap it is the minimum value. Performance: O(log n).
     */
    @discardableResult public mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }

        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            // Use the last node to replace the first one, then fix the heap by
            // shifting this new first node into its proper position.
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }

    /**
     * Takes a child node and looks at its parents; if a parent is not larger
     * (max-heap) or not smaller (min-heap) than the child, we exchange them.
     */
    internal mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: childIndex)

        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }

        nodes[childIndex] = child
    }

    /**
     * Looks at a parent node and makes sure it is still larger (max-heap) or
     * smaller (min-heap) than its childeren.
     */
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1

        // Figure out which comes first if we order them by the sort function:
        // the parent, the left child, or the right child. If the parent comes
        // first, we're done. If not, that element is out-of-place and we make
        // it "float down" the tree until the heap property is restored.
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        if first == index { return }

        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }

    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }

    @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }

    @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
        return 2 * i + 1
    }

    @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
        return 2 * i + 2
    }
}

// MARK: Heap extension
extension Heap {
    /**
     * Adds a sequence of values to the heap. This reorders the heap so that
     * the max-heap or min-heap property still holds. Performance: O(log n).
     */
    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }

    /**
     * Allows you to change an element. This reorders the heap so that
     * the max-heap or min-heap property still holds.
     */
    public mutating func replace(index i: Int, value: T) {
        guard i < nodes.count else { return }
        remove(at: i)
        insert(value)
    }

    /**
     * Removes an arbitrary node from the heap. Performance: O(log n).
     * Note that you need to know the node's index.
     */
    @discardableResult public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil }

        let size = nodes.count - 1
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(from: index, until: size)
            shiftUp(index)
        }
        return nodes.removeLast()
    }
}

extension Heap where T: Equatable {
    func index(of node: T) -> Int? {
        return nodes.firstIndex(where: { $0 == node })
    }

    @discardableResult mutating func remove(node: T) -> T? {
        if let index = index(of: node) {
            return remove(at: index)
        }
        return nil
    }
}

// MARK: PriorityQueue(heap based)
fileprivate struct PriorityQueue<T> {
    private var heap: Heap<T>

    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        heap = Heap(array: array, sort: sort)
    }

    public var isEmpty: Bool {
        return heap.isEmpty
    }

    public var count: Int {
        return heap.count
    }

    public func peek() -> T? {
        return heap.peek()
    }

    public mutating func enqueue(_ element: T) {
        heap.insert(element)
    }

    public mutating func dequeue() -> T? {
        return heap.remove()
    }
}

extension PriorityQueue {
    /*
     Allows you to change the priority of an element. In a max-priority queue,
     the new priority should be larger than the old one; in a min-priority queue
     it should be smaller.
     */
    mutating func changePriority(index i: Int, value: T) {
        return heap.replace(index: i, value: value)
    }
}

extension PriorityQueue where T: Equatable {
    func index(of element: T) -> Int? {
        return heap.index(of: element)
    }
}

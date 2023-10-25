//
//  Queue.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

// https://github.com/ReactiveX/RxSwift/blob/main/Platform/DataStructures/Queue.swift
struct Queue<T> {
    private let resizeFactor = 2
    private var storage: ContiguousArray<T?>
    private var innerCount = 0
    private var pushNextIndex = 0
    private let initialCapacity: Int

    init(capacity: Int) {
        initialCapacity = capacity
        storage = ContiguousArray<T?>(repeating: nil, count: capacity)
    }

    private var dequeueIndex: Int {
        let index = pushNextIndex - count
        return index < 0 ? index + storage.count : index
    }

    var isEmpty: Bool { count == 0 }
    var count: Int { innerCount }

    // O(1)
    func peek() -> T {
        precondition(count > 0)
        return storage[dequeueIndex]!
    }

    // O(1)
    mutating func enqueue(_ element: T) {
        if count == storage.count {
            resizeTo(Swift.max(storage.count, 1) * resizeFactor)
        }

        storage[pushNextIndex] = element
        pushNextIndex += 1
        innerCount += 1

        if pushNextIndex >= storage.count {
            pushNextIndex -= storage.count
        }
    }

    // O(1)
    mutating func dequeue() -> T? {
        if self.count == 0 {
            return nil
        }
        defer {
            let downsizeLimit = storage.count / (resizeFactor * resizeFactor)
            if count < downsizeLimit && downsizeLimit >= initialCapacity {
                resizeTo(storage.count / resizeFactor)
            }
        }
        return dequeueElementOnly()
    }
}

extension Queue: Sequence {
    mutating private func resizeTo(_ size: Int) {
        var newStorage = ContiguousArray<T?>(repeating: nil, count: size)

        let count = self.count

        let dequeueIndex = self.dequeueIndex
        let spaceToEndOfQueue = storage.count - dequeueIndex

        // first batch is from dequeue index to end of array
        let countElementsInFirstBatch = Swift.min(count, spaceToEndOfQueue)
        // second batch is wrapped from start of array to end of queue
        let numberOfElementsInSecondBatch = count - countElementsInFirstBatch

        newStorage[0 ..< countElementsInFirstBatch] = storage[dequeueIndex ..< (dequeueIndex + countElementsInFirstBatch)]
        newStorage[countElementsInFirstBatch ..< (countElementsInFirstBatch + numberOfElementsInSecondBatch)] = storage[0 ..< numberOfElementsInSecondBatch]

        self.innerCount = count
        pushNextIndex = count
        storage = newStorage
    }

    private mutating func dequeueElementOnly() -> T {
        precondition(count > 0)

        let index = dequeueIndex
        defer {
            storage[index] = nil
            innerCount -= 1
        }
        return storage[index]!
    }

    func makeIterator() -> AnyIterator<T> {
        var i = dequeueIndex
        var innerCount = count

        return AnyIterator {
            if innerCount == 0 {
                return nil
            }

            defer {
                innerCount -= 1
                i += 1
            }

            if i >= self.storage.count {
                i -= self.storage.count
            }

            return self.storage[i]
        }
    }
}

// MARK: ArrayQueue
fileprivate struct ArrayQueue<T> {
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

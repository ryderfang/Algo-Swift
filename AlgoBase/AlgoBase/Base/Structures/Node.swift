//
//  Node.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/13.
//

import Foundation

// lc116
public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    // lc133
    public var neighbors: [Node?]
    // lc138
    public var random: Node?
    // lc559
    public var children: [Node]

    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
        self.neighbors = []
        self.random = nil
        self.children = []
    }
}

public extension Node {
    func nextArray() -> [Any] {
        var result = [Any]()
        var tree: [Node] = [self]
        while !tree.isEmpty {
            guard tree.count > 0 else { break }
            var node: Node? = tree[0]
            while node != nil {
                guard let tmp = node else { break }
                result.append(tmp.val)
                node = tmp.next
            }
            result.append("#")
            tree = tree.flatMap { [$0.left, $0.right].compactMap { $0 } }
        }
        return result
    }

    func array() -> [Int?] {
        var result = [Int?]()
        var tree: [Node?] = [self]
        while !tree.isEmpty {
            guard tree.compactMap({ $0 }).count > 0 else { break }
            result.append(contentsOf: tree.map { $0?.val })
            tree = tree.compactMap { $0 }.flatMap { [$0?.left, $0?.right] }
        }
        // remove nils at last
        while let last = result.last, last == nil {
            result.removeLast()
        }
        return result
    }

    static func arrayToNode(_ nums: [Int?]) -> Node? {
        guard nums.count > 0 else { return nil }
        guard let rootVal = nums[0] else { return nil }
        let root = Node(rootVal)
        var queue: [Node?] = [root]
        var i = 1
        let sz = nums.count
        while !queue.isEmpty && i < sz {
            let node = queue.removeFirst()
            if let val = nums[i] {
                let left = Node(val)
                node?.left = left
                queue.append(left)
            }
            i += 1
            if i >= sz {
                break
            }
            if let val = nums[i] {
                let right = Node(val)
                node?.right = right
                queue.append(right)
            }
            i += 1
        }
        return root
    }
}

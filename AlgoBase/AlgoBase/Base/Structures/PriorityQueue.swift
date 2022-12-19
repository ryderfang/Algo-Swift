//
//  PriorityQueue.swift
//  AlgoBase
//
//  Created by ryfang on 2022/10/15.
//

import Foundation

private final class HeapBasedMinPQ {
    private var pq: [Int?] = [nil]
    private var n: Int

    public init(with array: [Int]) {
        n = array.count

        guard !array.isEmpty else { return }
        pq = .init(repeating: nil, count: array.count + 1)

        for i in 0..<array.count {
            pq[i + 1] = array[i]
        }

        for k in (1...pq.count / 2).reversed() {
            sink(k)
        }
    }

    public func insert(_ value: Int) {
        if pq.count - 1 == n {
            resize(pq.count * 2)
        }

        n += 1
        pq[n] = value
        swim(n)
    }

    public func deleteMin() -> Int? {
        guard !isEmpty() else { return nil }
        let minItem = pq[1]

        exchange(1, n)
        pq[n] = nil
        n -= 1
        sink(1)

        if n > 0, n == (pq.count - 1) / 4 {
            resize(pq.count / 2)
        }

        return minItem
    }

    public func minItem() -> Int? {
        return isEmpty() ? nil : pq[1]
    }

    public func size() -> Int {
        return n
    }

    private func isEmpty() -> Bool {
        return n == 0
    }

    private func sink(_ k: Int) {
        var k = k

        while 2 * k <= n {
            var j = 2 * k

            if j < n, pq[j]! > pq[j + 1]! {
                j += 1
            }

            guard pq[k]! > pq[j]! else { break }
            exchange(k, j)
            k = j
        }
    }

    private func swim(_ k: Int) {
        var k = k

        while k > 1, pq[k]! < pq[k / 2]! {
            exchange(k, k / 2)
            k /= 2
        }
    }

    private func exchange(_ i: Int, _ j: Int) {
        let swap = pq[i]!
        pq[i]! = pq[j]!
        pq[j]! = swap
    }

    private func resize(_ capacity: Int) {
        guard capacity > n else { return }
        var temp: [Int?] = .init(repeating: nil, count: capacity)

        if !isEmpty() {
            for i in 1...n {
                temp[i] = pq[i]
            }
        }

        pq = temp
    }
}

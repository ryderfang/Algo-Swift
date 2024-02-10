//
//  HeapSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

// 堆排序（不稳定）
// In-place
// 时间：O(nlogn)
// 空间：O(1)
extension Sort {
    static func heapSort(_ nums: [Int]) -> [Int] {
        var h = Heap(array: nums, sort: <)
        return h.sort()
    }
}

fileprivate extension Heap where T == Int {
    mutating func sort() -> [Int] {
        for i in stride(from: nodes.count - 1, through: 1 , by: -1) {
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
        }
        return nodes
    }
}

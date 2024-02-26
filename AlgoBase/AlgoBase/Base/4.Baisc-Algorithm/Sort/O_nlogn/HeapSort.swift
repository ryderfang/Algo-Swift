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

    func _heapSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        func _heapIfy(_ nums: inout [Int], _ n: Int, _ i: Int) {
            let l = 2 * i + 1
            let r = 2 * i + 2
            var largest = i
            if l < n && nums[largest] < nums[l] {
                largest = l
            }
            if r < n && nums[largest] < nums[r] {
                largest = r
            }
            if largest != i {
                nums.swapAt(largest, i)
                _heapIfy(&nums, n, largest)
            }
        }
        let n = nums.count
        // build maxHeap
        for i in stride(from: n / 2, through: 0, by: -1) {
            _heapIfy(&nums, n, i)
        }
        for i in stride(from: n - 1, through: 0, by: -1) {
            // 最大值移动到最后
            nums.swapAt(i, 0)
            _heapIfy(&nums, i, 0)
        }
        return nums
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

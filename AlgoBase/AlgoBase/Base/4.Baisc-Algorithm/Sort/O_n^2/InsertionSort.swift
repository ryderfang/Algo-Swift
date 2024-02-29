//
//  InsertionSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

// 插入排序（稳定）
// In-place
// 时间：O(n^2)
// 空间：O(1)
extension Sort {
    static func insertionSort(_ nums: inout [Int]) {
        let n = nums.count
        for i in 1..<n {
            let cur = nums[i]
            for j in (0..<i).reversed() {
                if nums[j] > cur {
                    nums.swapAt(j, j + 1)
                }
            }
        }
    }

    // ref: lc147
    static func insertionSort1(_ nums: inout [Int]) {
        insertionSort(&nums, start: 0, gap: 1)
    }

    static func insertionSort(_ nums: inout [Int], start: Int, gap: Int) {
        let n = nums.count
        for i in stride(from: start + gap, to: n, by: gap) {
            let key = nums[i]
            var pos = i
            while pos >= gap && nums[pos-gap] > key {
                nums[pos] = nums[pos-gap]
                pos -= gap
            }
            nums[pos] = key
        }
    }
}

// 插入有序数组
extension Array where Element: Comparable {
    // count strictly less than target
    // lower_bound
    func bisectLeft(_ target: Element) -> Int {
        var (lo, hi) = (0, count)
        while lo < hi {
            let mid = lo + (hi - lo) / 2
            if self[mid] < target {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        return lo
    }

    // count less or equal than target
    // upper_bound
    func bisectRight(_ target: Element) -> Int {
        var (lo, hi) = (0, count)
        while lo < hi {
            let mid = lo + (hi - lo) / 2
            if self[mid] <= target {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        return lo
    }

    mutating func insort(_ element: Element) {
        let i = bisectRight(element)
        insert(element, at: i)
    }
}

//
//  QuickSort.swift
//  AlgoBase
//
//  Created by Ryder on 2022/10/28.
//

import Foundation

class Sort {
}

// 快速排序（不稳定）
// 时间：O(nlogn)
// 空间：O(logn)
extension Sort {
    static func quickSort(_ nums: inout [Int]) {
        quickSort(0, nums.count - 1, &nums)
    }

    static func quickSort(_ beg: Int, _ end: Int, _ nums: inout [Int]) {
        var i = beg, j = end, x = nums[(beg + end) / 2]
        while true {
            while nums[i] < x { i += 1 }
            while nums[j] > x { j -= 1 }
            if i <= j {
                nums.swapAt(i, j)
                i += 1
                j -= 1
            }
            guard i < j else { break }
        }
        if i < end {
            quickSort(i, end, &nums)
        }
        if j > beg {
            quickSort(beg, j, &nums)
        }
    }
}

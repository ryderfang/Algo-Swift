//
//  SelectionSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

// 选择排序（不稳定）
// In-place
// 时间：O(n^2)
// 空间：O(1)
extension Sort {
    static func selectionSort(_ nums: inout [Int]) {
        let n = nums.count
        for i in 0..<n-1 {
            var lowest = i
            for j in i+1..<n {
                if nums[j] < nums[lowest] {
                    lowest = j
                }
            }
            nums.swapAt(i, lowest)
        }
    }
}

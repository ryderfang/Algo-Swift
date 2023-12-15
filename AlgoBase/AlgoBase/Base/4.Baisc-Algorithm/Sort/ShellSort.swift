//
//  ShellSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

// 希尔排序（不稳定）
// 时间：O(nlogn)
// 空间：O(1)
extension Sort {
    // 改进版的插入排序，按步长 [n/2, n/4, ... 1] 插入排序
    static func shellSort(_ nums: inout [Int]) {
        var step = nums.count / 2
        while step > 0 {
            for i in 0..<step {
                insertionSort(&nums, start: i, gap: step)
            }
            step /= 2
        }
    }
}

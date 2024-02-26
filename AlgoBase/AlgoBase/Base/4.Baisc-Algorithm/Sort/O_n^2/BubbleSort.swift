//
//  BubbleSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

// 冒泡排序（稳定）
// In-place
// 时间：O(n^2)
// 空间：O(1)
extension Sort {
    static func bubbleSort(_ nums: inout [Int]) {
        let n = nums.count
        for i in 0..<n {
            for j in 1..<n-i {
                if nums[j] < nums[j-1] {
                    nums.swapAt(j, j-1)
                }
            }
        }
    }
}

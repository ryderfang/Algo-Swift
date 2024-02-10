//
//  CountingSort.swift
//  AlgoBase
//
//  Created by ryfang on 2024/2/7.
//

import Foundation

// 计数排序（稳定）
// Out-place
// 时间：O(n+k)
// 空间：O(k)
extension Sort {
    static func countingSort(_ nums: [Int]) -> [Int] {
        let maxElement = nums.max() ?? 0
        var countArray = [Int](repeating: 0, count: maxElement + 1)
        for ele in nums {
            countArray[ele] += 1
        }
        for i in 1..<countArray.count {
            countArray[i] += countArray[i-1]
        }
        let n = nums.count
        var sortedArray = [Int](repeating: 0, count: n)
        for i in stride(from: n - 1, through: 0, by: -1) {
            let ele = nums[i]
            countArray[ele] -= 1
            sortedArray[countArray[ele]] = ele
        }
        return sortedArray
    }
}

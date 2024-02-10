//
//  RadixSort.swift
//  AlgoBase
//
//  Created by ryfang on 2024/2/7.
//

import Foundation

// 基数排序（稳定）
// Out-place
// 时间：O(n*k)
// 空间：O(n+k)
extension Sort {
    // 从低位向高位 (LSD, Least significant digital)
    static func radixSort(_ nums: inout [Int]) {
        let radix = 10
        var done = false
        var digit = 1
        while !done {
            done = true
            var buckets: [[Int]] = []
            for _ in 1...radix {
                buckets.append([])
            }
            for x in nums {
                let index = x / digit
                buckets[index % radix].append(x)
                if done && index > 0 {
                    done = false
                }
            }

            var i = 0
            for j in 0..<radix {
                let bucket = buckets[j]
                for x in bucket {
                    nums[i] = x
                    i += 1
                }
            }

            digit *= radix
        }
    }
}

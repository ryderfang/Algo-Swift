//
//  BucketSort.swift
//  AlgoBase
//
//  Created by ryfang on 2024/2/7.
//

import Foundation

// 桶排序（稳定）
// Out-place
// 时间：O(n+k)
// 空间：O(n+k)
extension Sort {
    static func bucketSort(_ nums: [Int], _ bucketSize: Int = 10) -> [Int] {
        guard let minV = nums.min(), let maxV = nums.max() else { return nums }
        var buckets = [[Int]](repeating: [], count: (maxV - minV) / bucketSize + 1)
        for x in nums {
            let index = (x - minV) / bucketSize
            buckets[index].append(x)
        }
        var ans = [Int]()
        for bucket in buckets {
            guard bucket.count > 0 else { continue }
            ans.append(contentsOf: bucket.insertionSort())
        }
        return ans
    }
}

fileprivate extension Array where Element == Int {
    func insertionSort() -> [Int] {
        var results = self
        for i in 0..<results.count {
            var j = i
            while j > 0 && results[j-1] > results[j] {
                let auxiliar = results[j-1]
                results[j-1] = results[j]
                results[j] = auxiliar
                j -= 1
            }
        }
        return results
    }
}

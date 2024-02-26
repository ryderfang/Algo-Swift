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

    func _bucketSort(_ nums: [Int]) -> [Int] {
        let maxSize = Int(1e5 + 1)
        var bucket = [Int](repeating: 0, count: maxSize)
        let offSet = Int(5 * 1e4)
        let nums = nums.map { $0 + offSet }
        for x in nums {
            bucket[x] += 1
        }
        var ans = [Int]()
        for (x, c) in bucket.enumerated() {
            ans.append(contentsOf: [Int](repeating: x, count: c))
        }
        return ans.map { $0 - offSet }
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

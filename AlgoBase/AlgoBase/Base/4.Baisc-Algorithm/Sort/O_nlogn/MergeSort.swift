//
//  MergeSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

// 归并排序（稳定）
// Out-place
// 时间：O(nlogn)
// 空间：O(n)
extension Sort {
    static func mergeSort(_ nums: [Int]) -> [Int] {
        // merge two sorted array
        func _merge(_ leftPile: [Int], _ rightPile: [Int]) -> [Int] {
            var (leftIndex, rightIndex) = (0, 0)
            var orderedPile = [Int]()
            orderedPile.reserveCapacity(leftPile.count + rightPile.count)
            while true {
                guard leftIndex < leftPile.endIndex else {
                    orderedPile.append(contentsOf: rightPile[rightIndex..<rightPile.endIndex])
                    break
                }
                guard rightIndex < rightPile.endIndex else {
                    orderedPile.append(contentsOf: leftPile[leftIndex..<leftPile.endIndex])
                    break
                }
                if leftPile[leftIndex] < rightPile[rightIndex] {
                    orderedPile.append(leftPile[leftIndex])
                    leftIndex += 1
                } else {
                    orderedPile.append(rightPile[rightIndex])
                    rightIndex += 1
                }
            }
            return orderedPile
        }

        let n = nums.count
        guard n > 1 else { return nums }
        let mid = n / 2
        let leftArray = mergeSort(Array(nums[0..<mid]))
        let rightArray = mergeSort(Array(nums[mid..<n]))
        return _merge(leftArray, rightArray)
    }
}

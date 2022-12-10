//
//  InsertionSort.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/10.
//

import Foundation

extension Sort {
    static func insertionSort(_ nums: inout [Int]) {
        let n = nums.count
        for j in 1..<n {
            let key = nums[j]
            var i = j - 1
            while i >= 0 && nums[i] > key {
                nums[i+1] = nums[i]
                i -= 1
            }
            nums[i+1] = key
        }
    }
}

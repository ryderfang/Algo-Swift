//
//  001.max-sum-of-sub-sequence.swift
//  AlgoBase
//
//  Created by ryfang on 2024/12/1.
//

import Foundation

// hdu1003
// lc53
// lc1749
func maxSubArray(_ nums: [Int]) -> Int {
    var ans = Int.min, tmp = 0
    var s = 0, e = 0
    for i in 0..<nums.count {
        tmp += nums[i]
        if tmp > ans {
            ans = tmp
            e = i
        }
        if tmp <= 0 {
            tmp = 0
            s = i + 1
        }
    }
    print(s, e)
    return ans
}


//
//  BinarySearch.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/6/3.
//

import Foundation

class BinarySearch {
    // MARK: find index of x in nums
    func search(_ nums: [Int], _ x: Int) -> Int {
        var (l, r) = (0, nums.count)
        var m = 0
        while l < r {
            m = l + (r - l) / 2
            if nums[m] < x {
                l = m + 1
            } else {
                r = m
            }
        }
        if (l >= 0 && l < nums.count && nums[l] == x) {
            return l
        }
        return -1
    }
}

//
//  BinarySearch.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/6/3.
//

import Foundation

class BinarySearch {
    /*
     * @param nums contains values sorted in ascending order
     * @return the index if the target is found. Otherwise,
     * @return the index where it would be if it were inserted in order
     * https://leetcode.com/problems/search-insert-position/description/
    **/
    func search(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count
        while l < r {
            let m = l + (r - l) / 2
            if nums[m] < target {
                l = m + 1
            } else {
                r = m
            }
        }
        return l
    }

    // @return the index if the target is found, otherwise return -1
    func checkIfExists(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count
        while l < r {
            let m = l + (r - l) / 2
            if nums[m] < target {
                l = m + 1
            } else {
                r = m
            }
        }
        if ((0..<nums.count).contains(l) && nums[l] == target) {
            return l
        }
        return -1
    }
}

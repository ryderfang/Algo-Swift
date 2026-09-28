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
    static func searchIndex(_ nums: [Int], _ target: Int) -> Int {
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
    static func find(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count
        while l < r {
            let m = l + (r - l) / 2
            guard nums[m] != target else { return m }
            if nums[m] < target {
                l = m + 1
            } else {
                r = m
            }
        }
        return -1
    }

    static func find2(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1 // diff
        while l <= r {
            let m = l + (r - l) / 2
            guard nums[m] != target else { return m }
            if nums[m] < target {
                l = m + 1
            } else {
                r = m - 1   // diff
            }
        }
        return -1
    }
}

class Search {
    
}

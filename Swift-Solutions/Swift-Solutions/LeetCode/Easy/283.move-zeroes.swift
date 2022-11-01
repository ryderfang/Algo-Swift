/*
 * @lc app=leetcode id=283 lang=swift
 *
 * [283] Move Zeroes
 */

// @lc code=start
class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        let n = nums.count
        guard n > 1 else { return }
        var i = 0
        var j = 1
        while i < n && j < n {
            if nums[i] == 0 {
                if nums[j] != 0 {
                    nums.swapAt(i, j)
                    i += 1
                }
                j += 1
            } else {
                i += 1
                j += 1
            }
        }
    }
}
// @lc code=end


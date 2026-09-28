/*
 * @lc app=leetcode id=35 lang=swift
 *
 * [35] Search Insert Position
 */

// @lc code=start
extension Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
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
}
// @lc code=end


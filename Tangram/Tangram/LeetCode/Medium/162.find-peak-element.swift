/*
 * @lc app=leetcode id=162 lang=swift
 *
 * [162] Find Peak Element
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 极大值
    func findPeakElement(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return 0 }
        if nums[0] > nums[1] {
            return 0
        }
        if nums[n-1] > nums[n-2] {
            return n - 1
        }
        var left = 0, right = n - 1
        while left < right {
            let mid = (left + right) / 2
            if nums[mid-1] < nums[mid] && nums[mid] > nums[mid+1] {
                return mid
            }
            if nums[mid-1] > nums[mid] {
                right = mid
            } else if nums[mid] < nums[mid+1] {
                left = mid
            }
        }
        return left
    }
}
// @lc code=end


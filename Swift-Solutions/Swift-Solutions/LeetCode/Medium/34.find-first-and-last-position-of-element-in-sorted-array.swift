/*
 * @lc app=leetcode id=34 lang=swift
 *
 * [34] Find First and Last Position of Element in Sorted Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let n = nums.count
        guard n > 0 else { return [-1, -1] }
        var left = 0, right = n - 1
        while left < right {
            let mid = (left + right) / 2
            if mid == left {
                break
            }
            if nums[mid] >= target {
                right = mid
            } else {
                left = mid
            }
        }
        var boundLeft = -1
        if nums[left] == target {
            boundLeft = left
        } else if nums[right] == target {
            boundLeft = right
        }
        left = 0
        right = n - 1
        while left < right {
            let mid = (left + right) / 2
            if mid == left {
                break
            }
            if nums[mid] <= target {
                left = mid
            } else {
                right = mid
            }
        }
        var boundRight = -1
        if nums[right] == target {
            boundRight = right
        } else if nums[left] == target {
            boundRight = left
        }
        return [boundLeft, boundRight]
    }
}
// @lc code=end


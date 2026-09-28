/*
 * @lc app=leetcode id=153 lang=swift
 *
 * [153] Find Minimum in Rotated Sorted Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findMin(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return nums[0] }
        var left = 0, right = n - 1
        var bound = 0
        while nums[left] > nums[right] {
            let mid = (left + right) / 2
            if mid == left {
                bound = mid
                break
            }
            if nums[mid] < nums[right] {
                right = mid
            } else {
                left = mid
            }
        }
        return min(nums[bound], nums[bound+1])
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=628 lang=swift
 *
 * [628] Maximum Product of Three Numbers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maximumProduct(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        let n = nums.count
        return max(nums[n-1] * nums[n-2] * nums[n-3], nums[0] * nums[1] * nums[n-1], nums[0] * nums[1] * nums[2])
    }
}
// @lc code=end


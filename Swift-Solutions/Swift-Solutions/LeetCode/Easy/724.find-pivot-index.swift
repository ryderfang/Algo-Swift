/*
 * @lc app=leetcode id=724 lang=swift
 *
 * [724] Find Pivot Index
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func pivotIndex(_ nums: [Int]) -> Int {
        let sum = nums.reduce(0, +)
        var count = 0
        for i in 0..<nums.count {
            if count == (sum - count - nums[i]) {
                return i
            }
            count += nums[i]
        }
        return -1
    }
}
// @lc code=end


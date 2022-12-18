/*
 * @lc app=leetcode id=674 lang=swift
 *
 * [674] Longest Continuous Increasing Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findLengthOfLCIS(_ nums: [Int]) -> Int {
        var ans = 1, count = 1
        let n = nums.count
        for i in 1..<n {
            if nums[i] > nums[i-1] {
                count += 1
            } else {
                ans = max(ans, count)
                count = 1
            }
        }
        ans = max(ans, count)
        return ans
    }
}
// @lc code=end


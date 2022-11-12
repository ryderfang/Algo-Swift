/*
 * @lc app=leetcode id=485 lang=swift
 *
 * [485] Max Consecutive Ones
 */

// @lc code=start
extension Solution {
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var ans = 0, count = 0
        for x in nums {
            if x == 1 {
                count += 1
            } else {
                ans = max(ans, count)
                count = 0
            }
        }
        ans = max(ans, count)
        return ans
    }
}
// @lc code=end


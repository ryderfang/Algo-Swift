/*
 * @lc app=leetcode id=376 lang=swift
 *
 * [376] Wiggle Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // O(n^2)
    func wiggleMaxLength1(_ nums: [Int]) -> Int {
        let n = nums.count
        var dp = [(inc: Int, dec: Int)](repeating: (inc: 1, dec: 1), count: n)
        for i in 1..<n {
            for j in 0..<i {
                if nums[i] > nums[j] {
                    dp[i].inc = max(dp[i].inc, dp[j].dec + 1)
                } else if nums[i] < nums[j] {
                    dp[i].dec = max(dp[i].dec, dp[j].inc + 1)
                }
            }
        }
        return max(dp[n-1].inc, dp[n-1].dec)
    }

    // Better solution: O(n)
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        let n = nums.count
        var (peak, valley) = (1, 1)
        for i in 1..<n {
            if nums[i] > nums[i-1] {
                peak = valley + 1
            } else if nums[i] < nums[i-1] {
                valley = peak + 1
            }
        }
        return max(peak, valley)
    }
}
// @lc code=end

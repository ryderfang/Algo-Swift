/*
 * @lc app=leetcode id=152 lang=swift
 *
 * [152] Maximum Product Subarray
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return nums[0] }
        // 二维变一维，dp[i] 表示 i 到当前位置的最大值
        var dp = [Int](repeating: 0, count: n)
        dp[0] = nums[0]
        var ans = nums[0]
        for i in 1..<n {
            dp[i] = nums[i]
            ans = max(ans, dp[i])
            for j in 0..<i {
                dp[j] = dp[j] * nums[i]
                ans = max(ans, dp[j])
            }
        }
        return ans
    }
}
// @lc code=end


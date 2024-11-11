/*
 * @lc app=leetcode id=650 lang=swift
 *
 * [650] 2 Keys Keyboard
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // n <- [1, 1000]
    func minSteps(_ n: Int) -> Int {
        var dp = [Int](repeating: Int.max, count: n + 1)
        dp[1] = 0
        var i = 1
        while i <= n {
            var j = 2
            while i * j <= n {
                dp[i*j] = min(dp[i*j], dp[i] + j)
                j += 1
            }
            i += 1
        }
        return dp[n]
    }
}
// @lc code=end


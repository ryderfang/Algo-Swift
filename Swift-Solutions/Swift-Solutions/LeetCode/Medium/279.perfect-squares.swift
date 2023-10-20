/*
 * @lc app=leetcode id=279 lang=swift
 *
 * [279] Perfect Squares
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numSquares(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 0...n {
            dp[i] = i
        }
        for i in 1...n {
            var j = 1
            while j * j <= i {
                dp[i] = min(dp[i], dp[i - j * j] + 1)
                j += 1
            }
        }
        return dp[n]
    }
}
// @lc code=end


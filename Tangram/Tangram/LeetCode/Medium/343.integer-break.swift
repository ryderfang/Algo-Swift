/*
 * @lc app=leetcode id=343 lang=swift
 *
 * [343] Integer Break
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func integerBreak(_ n: Int) -> Int {
        var dp = [Int](repeating: 1, count: n + 1)
        dp[1] = 1
        for i in 2...n {
            for j in 1...i-1 {
                dp[i] = max(dp[i], dp[j] * dp[i-j],
                            dp[j] * (i-j), j * dp[i-j],
                            j * (i-j))
            }
        }
        return dp[n]
    }

    // Better solution
    func integerBreak2(_ n: Int) -> Int {
        guard n >= 4 else { return n - 1 }
        var dp = [Int](repeating: 1, count: n + 1)
        (dp[1], dp[2], dp[3]) = (1, 2, 3)
        for i in 4...n {
            dp[i] = i
            for j in 2..<i {
                dp[i] = max(dp[i], j * dp[i-j])
            }
        }
        return dp[n]
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=1621 lang=swift
 *
 * [1621] Number of Sets of K Non-Overlapping Line Segments
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numberOfSets(_ n: Int, _ k: Int) -> Int {
        let mod: Int = Int(1e9 + 7)
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
        for i in 2...n {
            dp[i][1] = i * (i - 1) / 2
        }
        for i in 2...n {
            dp[i][i-1] = 1
        }
        for i in 2...n {
            for j in 1...(i-1) {
                guard dp[i][j] == 0 else { continue }
                dp[i][j] = (dp[i-1][j] + (dp[i-1][j-1] + dp[i-1][j] - dp[i-2][j]) + mod) % mod
                // TLE
//                dp[i][j] += dp[i-1][j]
//                for k in 2..<i {
//                    guard k >= j else { continue }
//                    dp[i][j] = (dp[i][j] % mod + dp[k][j-1]) % mod
//                }
            }
        }
        return dp[n][k] % mod
    }
}
// @lc code=end


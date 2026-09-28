/*
 * @lc app=leetcode id=2466 lang=swift
 *
 * [2466] Count Ways To Build Good Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func countGoodStrings(_ low: Int, _ high: Int, _ zero: Int, _ one: Int) -> Int {
        let mod = Int(1e9 + 7)
        var dp = [Int](repeating: 0, count: high + 1)
        dp[0] = 1
        for j in 0...high {
            if j >= zero {
                dp[j] = (dp[j] % mod + dp[j-zero] % mod) % mod
            }
            if j >= one {
                dp[j] = (dp[j] % mod + dp[j-one] % mod) % mod
            }
        }
        var ans = 0
        for i in low...high {
            ans = (ans % mod + dp[i] % mod) % mod
        }
        return ans % mod
    }
} 
// @lc code=end


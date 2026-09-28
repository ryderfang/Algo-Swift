/*
 * @lc app=leetcode id=1025 lang=swift
 *
 * [1025] Divisor Game
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func divisorGame(_ n: Int) -> Bool {
        return n % 2 == 0
    }

    // n -> n - x; 0 < x < n, n % x == 0
    func divisorGame1(_ n: Int) -> Bool {
        var dp = [Bool](repeating: false, count: n + 1)
        guard n > 1 else { return dp[n] }
        for i in 2...n {
            for j in 1..<i {
                if dp[j] == false && i % (i - j) == 0 {
                    dp[i] = true
                    break
                }
            }
        }
        return dp[n]
    }
}
// @lc code=end

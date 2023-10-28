/*
 * @lc app=leetcode id=322 lang=swift
 *
 * [322] Coin Change
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: dp[i] = min(dp[i], dp[i-c] + 1), i <- [1...n]
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        let n = coins.count
        var dp = [Int](repeating: Int.max, count: 10001)
        for (i, c) in coins.enumerated() {
            if i == 0 {
                for j in 0... {
                    guard c * j <= amount else { break }
                    dp[c * j] = j
                }
                continue
            }
            for j in 0... {
                guard c * j <= amount else { break }
                for k in 0..<10001 {
                    guard c * j + k <= amount else { break }
                    if dp[k] < Int.max {
                        dp[k + c * j] = min(dp[k + c * j], dp[k] + j)
                    }
                }
            }
        }
        return dp[amount] == Int.max ? -1 : dp[amount]
    }
}
// @lc code=end


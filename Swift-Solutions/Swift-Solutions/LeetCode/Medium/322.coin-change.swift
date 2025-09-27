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
    // 完全背包问题
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        let n = coins.count
        var dp = Array(repeating: Int.max, count: amount + 1)
        dp[0] = 0
        for i in 0..<n {
            guard coins[i] <= amount else { continue }
            for v in coins[i]...amount {
                if dp[v-coins[i]] != Int.max {
                    dp[v] = min(dp[v], dp[v-coins[i]] + 1)
                }
            }
        }
        return dp[amount] == Int.max ? -1 : dp[amount]
    }
    
    func coinChange1(_ coins: [Int], _ amount: Int) -> Int {
        let n = coins.count
        var dp = Array(repeating: Int.max, count: amount + 1)
        dp[0] = 0
        for i in 0..<n {
            for v in stride(from: amount, to: 0, by: -1) {
                for k in stride(from: v / coins[i], to: 0, by: -1) {
                    // different with original pack
                    if dp[v - k * coins[i]] != Int.max {
                        dp[v] = min(dp[v], dp[v - k * coins[i]] + k)
                    }
                }
            }
        }
        return dp[amount] == Int.max ? -1 : dp[amount]
    }
    
    func coinChange2(_ coins: [Int], _ amount: Int) -> Int {
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


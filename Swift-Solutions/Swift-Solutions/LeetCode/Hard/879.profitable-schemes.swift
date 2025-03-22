/*
 * @lc app=leetcode id=879 lang=swift
 *
 * [879] Profitable Schemes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func profitableSchemes(_ n: Int, _ minProfit: Int, _ group: [Int], _ profit: [Int]) -> Int {
        let mod = 1_000_000_007
        let len = group.count
        
        var dp = Array(repeating: Array(repeating: 0, count: minProfit + 1), count: n + 1)
        for i in 0...n {
            dp[i][0] = 1
        }
        
        for i in 0..<len {
            let g = group[i]
            let p = profit[i]
            
            for j in stride(from: n, through: g, by: -1) {
                for k in stride(from: minProfit, through: 0, by: -1) {
                    dp[j][k] = (dp[j][k] + dp[j - g][max(0, k - p)]) % mod
                }
            }
        }
        
        return dp[n][minProfit]
    }
    
    func profitableSchemes1(_ n: Int, _ minProfit: Int, _ group: [Int], _ profit: [Int]) -> Int {
        let sz = profit.count
        let mod = Int(1e9 + 7)
        let maxProfit = profit.reduce(0, +)
        guard minProfit <= maxProfit else { return 0 }
        
        var dp = Array(repeating: Array(repeating: Int.min, count: n + 1), count: maxProfit + 1)
        // empty subset [] is ok to get zero profit.
        dp[0][0] = 1
        for i in 0..<sz {
            for p in stride(from: maxProfit, through: profit[i], by: -1) {
                for g in stride(from: n, through: group[i], by: -1) {
                    if dp[p-profit[i]][g-group[i]] != Int.min {
                        if dp[p][g] != Int.min {
                            dp[p][g] = (dp[p][g] % mod + dp[p-profit[i]][g-group[i]] % mod) % mod
                        } else {
                            dp[p][g] = dp[p-profit[i]][g-group[i]]
                        }
                    }
                }
            }
        }
        var ans = 0
        for i in minProfit...maxProfit {
            for j in 0...n {
                if dp[i][j] != Int.min {
                    ans = (ans % mod + dp[i][j] % mod) % mod
                }
            }
        }
        return ans
    }
}
// @lc code=end


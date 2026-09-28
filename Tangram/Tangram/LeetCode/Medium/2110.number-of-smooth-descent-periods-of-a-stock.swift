/*
 * @lc app=leetcode id=2110 lang=swift
 *
 * [2110] Number of Smooth Descent Periods of a Stock
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func getDescentPeriods(_ prices: [Int]) -> Int {
        let n = prices.count
        var dp = [Int](repeating: 0, count: n)
        dp[n-1] = 1
        func _solve(_ i: Int) -> Int {
            guard i < n else { return 0 }
            guard dp[i] == 0 else { return dp[i] }
            var ret = 1
            if prices[i+1] == prices[i] - 1 {
                ret += _solve(i+1)
            }
            dp[i] = ret
            return dp[i]
        }
        var ans = 0
        for i in 0..<n {
            ans += _solve(i)
        }
        return ans
    }
}
// @lc code=end


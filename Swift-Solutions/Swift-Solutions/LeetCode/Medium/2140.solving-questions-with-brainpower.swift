/*
 * @lc app=leetcode id=2140 lang=swift
 *
 * [2140] Solving Questions With Brainpower
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func mostPoints(_ questions: [[Int]]) -> Int {
        let n = questions.count
        var dp = Array(repeating: 0, count: Int(2e5 + 1))
        for i in (0..<n).reversed() {
            dp[i] = max(dp[i+1], questions[i][0] + dp[i+questions[i][1] + 1])
        }
        return dp[0]
    }
    
    
    func mostPoints1(_ questions: [[Int]]) -> Int {
        let n = questions.count
        var dp = Array(repeating: -1, count: n)
        func _solve(_ i: Int) -> Int {
            guard dp[i] < 0 else { return dp[i] }
            guard i < n - 1 else {
                dp[i] = questions[i][0]
                return dp[i]
            }
            let nextSolvable = i + questions[i][1] + 1
            dp[i] = max(_solve(i+1), questions[i][0] + (nextSolvable < n ? _solve(nextSolvable) : 0))
            return dp[i]
        }
        _ = _solve(0)
        return dp.max()!
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=746 lang=swift
 *
 * [746] Min Cost Climbing Stairs
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        let n = cost.count
        guard n > 1 else { return 0 }
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 2...n {
            dp[i] = min(dp[i-1] + cost[i-1], dp[i-2] + cost[i-2])
        }
        return dp[n]
    }
}
// @lc code=end


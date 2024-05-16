/*
 * @lc app=leetcode id=2304 lang=swift
 *
 * [2304] Minimum Path Cost in a Grid
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minPathCost(_ grid: [[Int]], _ moveCost: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var dp = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: m)
        for j in 0..<n {
            dp[0][j] = grid[0][j]
        }
        for i in 1..<m {
            for j in 0..<n {
                var tmp = Int.max
                // min of [i-1][k] -> [i][j]
                for k in 0..<n {
                    let cost = moveCost[grid[i-1][k]][j]
                    tmp = min(tmp, dp[i-1][k] + cost  + grid[i][j])
                }
                dp[i][j] = tmp
            }
        }
        return dp[m-1].min() ?? 0
    }
}
// @lc code=end

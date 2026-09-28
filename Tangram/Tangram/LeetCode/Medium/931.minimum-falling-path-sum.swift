/*
 * @lc app=leetcode id=931 lang=swift
 *
 * [931] Minimum Falling Path Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minFallingPathSum(_ matrix: [[Int]]) -> Int {
        let n = matrix.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        for j in 0..<n {
            dp[n-1][j] = matrix[n-1][j]
        }
        for i in stride(from: n-2, through: 0, by: -1) {
            for j in 0..<n {
                dp[i][j] = matrix[i][j] + min(dp[i+1][max(0, j-1)], dp[i+1][j], dp[i+1][min(j+1, n-1)])
            }
        }
        return dp[0].min()!
    }
}
// @lc code=end


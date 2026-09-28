/*
 * @lc app=leetcode id=63 lang=swift
 *
 * [63] Unique Paths II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        guard obstacleGrid[0][0] == 0 && obstacleGrid[m-1][n-1] == 0 else { return 0 }
        var ans = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                if i == 0 && j == 0 {
                    ans[0][0] = 1
                } else {
                    ans[i][j] += (i > 0 && obstacleGrid[i-1][j] == 0) ? ans[i-1][j] : 0
                    ans[i][j] += (j > 0 && obstacleGrid[i][j-1] == 0) ? ans[i][j-1] : 0
                }
            }
        }
        return ans[m-1][n-1]
    }
}
// @lc code=end


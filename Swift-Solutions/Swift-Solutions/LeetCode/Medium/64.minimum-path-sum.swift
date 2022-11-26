/*
 * @lc app=leetcode id=64 lang=swift
 *
 * [64] Minimum Path Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var ans = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                if i == 0 && j == 0 {
                    ans[i][j] = grid[i][j]
                } else {
                    ans[i][j] = min(i > 0 ? ans[i-1][j] : Int.max, j > 0 ? ans[i][j-1] : Int.max) + grid[i][j]
                }
            }
        }
        return ans[m-1][n-1]
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=463 lang=swift
 *
 * [463] Island Perimeter
 */

// @lc code=start
class Solution {
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        var ans = 0
        let r = grid.count
        let c = grid[0].count
        for i in 0..<r {
            for j in 0..<c {
                if grid[i][j] == 1 {
                    // left
                    if j == 0 || (j > 0 && grid[i][j-1] == 0) {
                        ans += 1
                    }
                    // bottom
                    if i == r - 1 || (i < r - 1 && grid[i+1][j] == 0) {
                        ans += 1
                    }
                    // right
                    if j == c - 1 || (j < c - 1 && grid[i][j+1] == 0) {
                        ans += 1
                    }
                    // top
                    if i == 0 || (i > 0 && grid[i-1][j] == 0) {
                        ans += 1
                    }
                }
            }
        }
        return ans
    }
}
// @lc code=end


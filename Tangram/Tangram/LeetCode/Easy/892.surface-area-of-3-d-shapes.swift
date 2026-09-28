/*
 * @lc app=leetcode id=892 lang=swift
 *
 * [892] Surface Area of 3D Shapes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func surfaceArea(_ grid: [[Int]]) -> Int {
        var ans = 0
        let n = grid.count
        for i in 0..<n {
            for j in 0..<n {
                if grid[i][j] != 0 {
                    ans += 2
                }
                if j > 0 {
                    ans += abs(grid[i][j] - grid[i][j-1])
                } else {
                    ans += grid[i][j]
                }
                if j == n - 1 {
                    ans += grid[i][j]
                }
                if i > 0 {
                    ans += abs(grid[i][j] - grid[i-1][j])
                } else {
                    ans += grid[i][j]
                }
                if i == n - 1 {
                    ans += grid[i][j]
                }
            }
        }
        return ans
    }
}
// @lc code=end


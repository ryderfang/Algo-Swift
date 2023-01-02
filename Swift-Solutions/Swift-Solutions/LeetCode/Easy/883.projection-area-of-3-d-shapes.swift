/*
 * @lc app=leetcode id=883 lang=swift
 *
 * [883] Projection Area of 3D Shapes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func projectionArea(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var ans = 0
        for i in 0..<n {
            ans += grid[i].max()!
            var tmp = Int.min
            for j in 0..<n {
                if grid[j][i] > 0 {
                    ans += 1
                }
                tmp = max(tmp, grid[j][i])
            }
            ans += tmp
        }
        return ans
    }
}
// @lc code=end


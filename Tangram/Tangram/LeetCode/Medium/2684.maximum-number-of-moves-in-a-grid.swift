/*
 * @lc app=leetcode id=2684 lang=swift
 *
 * [2684] Maximum Number of Moves in a Grid
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxMoves(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var mem = [[Int]](repeating: [Int](repeating: -1, count: n), count: m)
        for i in 0..<m {
            mem[i][n-1] = 0
        }
        func _solve(_ last: Int, _ i: Int, _ j: Int) -> Int {
            guard i >= 0 && i < m && j >= 0 && j < n else {
                return -1
            }
            guard grid[i][j] > last else { return -1 }
            guard mem[i][j] == -1 else { return mem[i][j] }
            mem[i][j] = max(mem[i][j], _solve(grid[i][j], i - 1, j + 1) + 1)
            mem[i][j] = max(mem[i][j], _solve(grid[i][j], i, j + 1) + 1)
            mem[i][j] = max(mem[i][j], _solve(grid[i][j], i + 1, j + 1) + 1)
            return mem[i][j]
        }
        var ans = 0
        for i in 0..<m {
            ans = max(ans, _solve(0, i, 0))
        }
        return ans
    }
}
// @lc code=end


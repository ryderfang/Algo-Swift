/*
 * @lc app=leetcode id=200 lang=swift
 *
 * [200] Number of Islands
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var visit = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        func _dfs(_ x: Int, _ y: Int, _ visit: inout [[Int]]) {
            var stack = [(Int, Int)]()
            stack.append((x, y))
            visit[x][y] = 1
            while !stack.isEmpty {
                let last = stack.removeLast()
                let (i, j) = (last.0 , last.1)
                if j > 0 && visit[i][j-1] == 0 && grid[i][j-1] == "1" {
                    stack.append((i, j-1))
                    visit[i][j-1] = 1
                }
                if i > 0 && visit[i-1][j] == 0 && grid[i-1][j] == "1" {
                    stack.append((i-1, j))
                    visit[i-1][j] = 1
                }
                if j < n - 1 && visit[i][j+1] == 0 && grid[i][j+1] == "1" {
                    stack.append((i, j+1))
                    visit[i][j+1] = 1
                }
                if i < m - 1 && visit[i+1][j] == 0 && grid[i+1][j] == "1" {
                    stack.append((i+1, j))
                    visit[i+1][j] = 1
                }
            }
        }
        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == "1" && visit[i][j] == 0 {
                    _dfs(i, j, &visit)
                    ans += 1
                }
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=1030 lang=swift
 *
 * [1030] Matrix Cells in Distance Order
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func allCellsDistOrder(_ rows: Int, _ cols: Int, _ rCenter: Int, _ cCenter: Int) -> [[Int]] {
        var ans = [[Int]]()
        for i in 0..<rows {
            for j in 0..<cols {
                ans.append([i, j])
            }
        }
        ans.sort { (a, b) in
            abs(a[0] - rCenter) + abs(a[1] - cCenter) <
            abs(b[0] - rCenter) + abs(b[1] - cCenter)
        }
        return ans
    }

    func allCellsDistOrder1(_ rows: Int, _ cols: Int, _ rCenter: Int, _ cCenter: Int) -> [[Int]] {
        var ans = [[Int]]()
        var visited = Set<Int>()
        func _bfs(_ nodes: [[Int]], _ visited: inout Set<Int>, _ ans: inout [[Int]]) {
            guard !nodes.isEmpty else { return }
            var next = [[Int]]()
            for node in nodes {
                let (i, j) = (node[0], node[1])
                let idx = i * cols + j
                guard !visited.contains(idx) else { continue }
                visited.insert(idx)
                ans.append(node)
                if i - 1 >= 0 && !visited.contains((i - 1) * cols + j) {
                    next.append([i - 1, j])
                }
                if i + 1 < rows && !visited.contains((i + 1) * cols + j) {
                    next.append([i + 1, j])
                }
                if j - 1 >= 0 && !visited.contains(i * cols + j - 1) {
                    next.append([i, j - 1])
                }
                if j + 1 < cols && !visited.contains(i * cols + j + 1) {
                    next.append([i, j + 1])
                }
            }
            _bfs(next, &visited, &ans)
        }
        _bfs([[rCenter, cCenter]], &visited, &ans)
        return ans
    }
}
// @lc code=end

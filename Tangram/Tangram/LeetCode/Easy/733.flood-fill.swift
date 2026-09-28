/*
 * @lc app=leetcode id=733 lang=swift
 *
 * [733] Flood Fill
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        var image = image
        guard image[sr][sc] != color else { return image }
        let m = image.count
        let n = image[0].count
        var visit = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        func _dfs(_ i: Int, _ j: Int, _ target: Int) {
            guard i >= 0 && i < m && j >= 0 && j < n else { return }
            guard visit[i][j] == 0 else { return }
            guard image[i][j] == target else { return }
            visit[i][j] = 1
            image[i][j] = color
            _dfs(i-1, j, target)
            _dfs(i+1, j, target)
            _dfs(i, j-1, target)
            _dfs(i, j+1, target)
        }
        let target = image[sr][sc]
        _dfs(sr, sc, target)
        return image
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=79 lang=swift
 *
 * [79] Word Search
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count
        let n = board[0].count
        let word = Array(word)
        let visit = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        func _search(_ i: Int, _ j: Int, _ k: Int, _ visit: [[Int]]) -> Bool {
            guard k < word.count else { return true }
            guard i >= 0 && i < m && j >= 0 && j < n else { return false }
            guard visit[i][j] == 0 else { return false }
            guard board[i][j] == word[k] else { return false }
            var visit = visit
            visit[i][j] = 1
            if _search(i-1, j, k+1, visit) {
                return true
            }
            if _search(i, j-1, k+1, visit) {
                return true
            }
            if _search(i+1, j, k+1, visit) {
                return true
            }
            if _search(i, j+1, k+1, visit) {
                return true
            }
            return false
        }
        for i in 0..<m {
            for j in 0..<n {
                if _search(i, j, 0, visit) {
                    return true
                }
            }
        }
        return false
    }
}
// @lc code=end


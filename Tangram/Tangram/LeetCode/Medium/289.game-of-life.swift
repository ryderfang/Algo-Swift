/*
 * @lc app=leetcode id=289 lang=swift
 *
 * [289] Game of Life
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func gameOfLife(_ board: inout [[Int]]) {
        let m = board.count
        let n = board[0].count
        for i in 0..<m {
            for j in 0..<n {
                var c = 0

                if i > 0 && j > 0 {
                    c += origValue(board[i-1][j-1])
                }
                if i > 0 {
                    c += origValue(board[i-1][j])
                }
                if i > 0 && j < n - 1 {
                    c += origValue(board[i-1][j+1])
                }
                if i < m - 1 {
                    c += origValue(board[i+1][j])
                }
                if i < m - 1 && j > 0 {
                    c += origValue(board[i+1][j-1])
                }
                if i < m - 1 && j < n - 1 {
                    c += origValue(board[i+1][j+1])
                }
                if j > 0 {
                    c += origValue(board[i][j-1])
                }
                if j < n - 1 {
                    c += origValue(board[i][j+1])
                }

                // temp value
                if board[i][j] == 0 && c == 3 {
                    board[i][j] = -2
                }
                if board[i][j] == 1 && (c < 2 || c > 3) {
                    board[i][j] = -1
                }
            }
        }

        // recover
        for i in 0..<m {
            for j in 0..<n {
                if board[i][j] == -1 {
                    board[i][j] = 0
                }
                if board[i][j] == -2 {
                    board[i][j] = 1
                }
            }
        }
    }

    private func origValue(_ b: Int) -> Int {
        return (b < 0 ? b + 2 : b)
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=36 lang=swift
 *
 * [36] Valid Sudoku
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        func _isValid(_ nine: [Character]) -> Bool {
            var mp = [Character: Int]()
            var valid = true
            for ch in nine {
                if ch == Character(".") {
                    continue
                }
                if let _ = mp[ch] {
                    valid = false
                    break
                } else {
                    mp[ch] = 1
                }
            }
            return valid
        }

        guard board.count == 9 && board[0].count == 9 else { return false }
        // 1. check rows
        for row in board {
            if !_isValid(row) {
                return false
            }
        }

        // 2. check columns
        for j in 0..<9 {
            var col = [Character]()
            for i in 0..<9 {
                col.append(board[i][j])
            }
            if !_isValid(col) {
                return false
            }
        }

        // 3. check 3x3 sub-boxes
        for i in stride(from: 0, through: 6, by: 3) {
            for j in stride(from: 0, through: 6, by: 3) {
                var box = [Character]()
                for k in 0..<3 {
                    for l in 0..<3 {
                        box.append(board[i+k][j+l])
                    }
                }
                if !_isValid(box) {
                    return false
                }
            }
        }
        return true
    }
}
// @lc code=end


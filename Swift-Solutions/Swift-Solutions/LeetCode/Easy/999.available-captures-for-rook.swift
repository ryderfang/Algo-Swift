/*
 * @lc app=leetcode id=999 lang=swift
 *
 * [999] Available Captures for Rook
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numRookCaptures(_ board: [[Character]]) -> Int {
        // rock - 车，横竖走
        // bishops - 象，斜走
        // pawns - 兵，直走斜吃
        func _check(_ i: Int, _ horizontal: Bool, _ start: Int, _ end: Int, _ step: Int, _ ans: inout Int) {
            for k in stride(from: start, to: end, by: step) {
                let chess = horizontal ? board[i][k] : board[k][i]
                if chess == "p" {
                    ans += 1
                    break
                }
                if chess == "B" {
                    break
                }
                if chess == "." {
                    continue
                }
            }
        }

        var ans = 0
        for i in 0..<8 {
            for j in 0..<8 {
                if board[i][j] == "R" {
                    // west
                    _check(i, true, j - 1, -1, -1, &ans)
                    // east
                    _check(i, true, j + 1, 8, 1, &ans)
                    // north
                    _check(j, false, i - 1, -1, -1, &ans)
                    // south
                    _check(j, false, i + 1, 8, 1, &ans)
                }
            }
        }
        return ans
    }
}
// @lc code=end


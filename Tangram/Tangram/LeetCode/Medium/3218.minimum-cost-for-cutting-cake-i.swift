/*
 * @lc app=leetcode id=3218 lang=swift
 *
 * [3218] Minimum Cost for Cutting Cake I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minimumCost(_ m: Int, _ n: Int, _ horizontalCut: [Int], _ verticalCut: [Int]) -> Int {
        var mem = [Array<Int>: Int]()
        func _solve(_ i: Int, _ j: Int, _ row: Int, _ col: Int) -> Int {
            if let cache = mem[[i, j, row, col]] {
                return cache
            }
            if row == 1 && col == 1 {
                mem[[i, j, row, col]] = 0
                return 0
            }
            // horizontal
            var ans = Int.max
            if row >= 2 {
                for x in i...(i+row-2) {
                    ans = min(ans, _solve(i, j, x - i + 1, col) +
                                _solve(x + 1, j, row - (x - i + 1), col) +
                                horizontalCut[x])
                }
            }
            // vertical
            if col >= 2 {
                for y in j...(j+col-2) {
                    ans = min(ans, _solve(i, j, row, y - j + 1) +
                                _solve(i, y + 1, row, col - (y - j + 1)) +
                                verticalCut[y])
                }
            }
            mem[[i, j, row, col]] = ans
            return ans
        }
        return _solve(0, 0, m, n)
    }
}
// @lc code=end


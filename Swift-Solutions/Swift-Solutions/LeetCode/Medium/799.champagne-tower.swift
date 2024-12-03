/*
 * @lc app=leetcode id=799 lang=swift
 *
 * [799] Champagne Tower
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // row i, col [0, i]
    func champagneTower(_ poured: Int, _ query_row: Int, _ query_glass: Int) -> Double {
        var mem = [[Double]](repeating: [Double](repeating: 0, count: 101), count: 101)
        mem[0][0] = Double(poured)
        func _overflow(_ i: Int, _ j: Int) -> Double {
            if mem[i][j] > 1.0 {
                return (mem[i][j] - 1.0) / 2.0
            }
            return 0.0
        }

        for i in 0...query_row {
            for j in 0...i {
                if i == 0 && j == 0 {
                    //
                } else if j == 0 {
                    mem[i][j] = _overflow(i-1, j)
                } else if j == i {
                    mem[i][j] = _overflow(i-1, j-1)
                } else {
                    mem[i][j] = _overflow(i-1, j-1) + _overflow(i-1, j)
                }
            }
        }
        return min(mem[query_row][query_glass], 1.0)
    }
}
// @lc code=end


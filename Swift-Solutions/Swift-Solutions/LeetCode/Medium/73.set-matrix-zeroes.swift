/*
 * @lc app=leetcode id=73 lang=swift
 *
 * [73] Set Matrix Zeroes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] != 0 {
                    continue
                }
                for k in 0..<m {
                    matrix[k][j] = matrix[k][j] != 0 ? Int.max : matrix[k][j]
                }
                for k in 0..<n {
                    matrix[i][k] = matrix[i][k] != 0 ? Int.max : matrix[i][k]
                }
            }
        }
        for i in 0..<m {
            for j in 0..<n {
                matrix[i][j] = matrix[i][j] == Int.max ? 0 : matrix[i][j]
            }
        }
    }
}
// @lc code=end


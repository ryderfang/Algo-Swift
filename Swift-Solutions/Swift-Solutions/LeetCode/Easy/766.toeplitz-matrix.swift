/*
 * @lc app=leetcode id=766 lang=swift
 *
 * [766] Toeplitz Matrix
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
        let m = matrix.count
        let n = matrix[0].count
        var row = matrix[0]
        for i in 1..<m {
            for j in 1..<n {
                guard matrix[i][j] == row[j-1] else { return false }
            }
            row.insert(matrix[i][0], at: 0)
        }
        return true
    }
}
// @lc code=end


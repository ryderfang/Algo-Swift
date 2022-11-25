/*
 * @lc app=leetcode id=48 lang=swift
 *
 * [48] Rotate Image
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count
        for r in 0..<n/2 {
            let c = n - r * 2
            for i in 0..<c-1 {
                let p1 = matrix[r][r+i]
                let p2 = matrix[n-r-1-i][r]
                let p3 = matrix[n-r-1][n-r-1-i]
                let p4 = matrix[r+i][n-r-1]
                matrix[r][r+i] = p2
                matrix[n-r-1-i][r] = p3
                matrix[n-r-1][n-r-1-i] = p4
                matrix[r+i][n-r-1] = p1
            }
        }
    }
}
// @lc code=end


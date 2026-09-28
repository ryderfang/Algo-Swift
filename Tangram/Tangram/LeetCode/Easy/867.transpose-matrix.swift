/*
 * @lc app=leetcode id=867 lang=swift
 *
 * [867] Transpose Matrix
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        let (m, n) = (matrix.count, matrix[0].count)
        var ans = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
        for i in 0..<n {
            for j in 0..<m {
                ans[i][j] = matrix[j][i]
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=59 lang=swift
 *
 * [59] Spiral Matrix II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func generateMatrix(_ n: Int) -> [[Int]] {
        guard n > 1 else { return [[1]] }
        var matrix = [[Int]](repeating: [Int](repeating: -1, count: n), count: n)
        var x = 1
        for i in 0..<n/2 {
            for j in i..<n-i-1 {
                matrix[i][j] = x
                x += 1
            }
            for j in i..<n-i-1 {
                matrix[j][n-i-1] = x
                x += 1
            }
            for j in stride(from: n-i-1, to: i, by: -1) {
                matrix[n-i-1][j] = x
                x += 1
            }
            for j in stride(from: n-i-1, to: i, by: -1) {
                matrix[j][i] = x
                x += 1
            }
        }
        if n & 1 == 1 {
            matrix[n/2][n/2] = x
        }
        return matrix
    }
}
// @lc code=end


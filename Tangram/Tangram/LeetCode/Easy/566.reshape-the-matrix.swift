/*
 * @lc app=leetcode id=566 lang=swift
 *
 * [566] Reshape the Matrix
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
        let m = mat.count
        let n = mat[0].count
        guard r * c == m * n else { return mat }
        var ans = [[Int]](repeating: [Int](repeating: 0, count: c), count: r)
        var k = 0, l = 0
        for i in 0..<r {
            for j in 0..<c {
                ans[i][j] = mat[k][l]
                l += 1
                if l == n {
                    l = 0
                    k += 1
                }
            }
        }
        return ans
    }
}
// @lc code=end


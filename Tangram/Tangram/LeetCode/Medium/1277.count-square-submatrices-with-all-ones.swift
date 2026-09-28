/*
 * @lc app=leetcode id=1277 lang=swift
 *
 * [1277] Count Square Submatrices with All Ones
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // MARK: TODO
    // 二维前缀和
    func countSquares(_ matrix: [[Int]]) -> Int {
        let m = matrix.count
        let n = matrix[0].count
        var preSum = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                preSum[i][j] = matrix[i][j] +
                    (j > 0 ? preSum[i][j-1] : 0) +
                    (i > 0 ? preSum[i-1][j] : 0) -
                    ((i > 0 && j > 0) ? preSum[i-1][j-1] : 0)
            }
        }
        func _infixSum(_ from: (Int, Int), _ to: (Int, Int)) -> Int {
            return preSum[to.0][to.1] -
                (from.1 > 0 ? preSum[to.0][from.1 - 1] : 0) -
                (from.0 > 0 ? preSum[from.0 - 1][to.1] : 0) +
                ((from.0 > 0 && from.1 > 0) ? preSum[from.0 - 1][from.1 - 1] : 0)
        }

        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                let from = (i, j)
                for k in 1...min(m, n) {
                    let to = (from.0 + k - 1, from.1 + k - 1)
                    guard to.0 < m && to.1 < n else { break }
                    if _infixSum(from, to) == k * k {
                        ans += 1
                    }
                }
            }
        }
        return ans
    }
}
// @lc code=end

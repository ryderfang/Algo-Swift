/*
 * @lc app=leetcode id=54 lang=swift
 *
 * [54] Spiral Matrix
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var matrix = matrix
        let m = matrix.count
        let n = matrix[0].count
        var ans = [Int]()
        var p = (0, 0)
        while ans.count < m * n {
            for j in p.1..<n {
                guard matrix[p.0][j] > Int.min else { break }
                ans.append(matrix[p.0][j])
                matrix[p.0][j] = Int.min
                p.1 = j
            }
            for i in p.0+1..<m {
                guard matrix[i][p.1] > Int.min else { break }
                ans.append(matrix[i][p.1])
                matrix[i][p.1] = Int.min
                p.0 = i
            }
            for j in stride(from: p.1 - 1, through: 0, by: -1) {
                guard matrix[p.0][j] > Int.min else { break }
                ans.append(matrix[p.0][j])
                matrix[p.0][j] = Int.min
                p.1 = j
            }
            for i in stride(from: p.0 - 1, through: 0, by: -1) {
                guard matrix[i][p.1] > Int.min else { break }
                ans.append(matrix[i][p.1])
                matrix[i][p.1] = Int.min
                p.0 = i
            }
            p.1 += 1
        }
        return ans
    }
}
// @lc code=end


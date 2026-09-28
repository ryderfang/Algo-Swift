/*
 * @lc app=leetcode id=304 lang=swift
 *
 * [304] Range Sum Query 2D - Immutable
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class NumMatrix {
    let matrix: [[Int]]
    var (m, n) = (0, 0)
    var tbl: [[Int]]

    init(_ matrix: [[Int]]) {
        self.matrix = matrix
        m = matrix.count
        n = matrix[0].count
        tbl = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            var line = 0
            for j in 0..<n {
                line += matrix[i][j]
                if i > 0 {
                    tbl[i][j] += tbl[i-1][j]
                }
                tbl[i][j] += line
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var ans = tbl[row2][col2]
        if col1 > 0 {
            ans -= tbl[row2][col1-1]
        }
        if row1 > 0 {
            ans -= tbl[row1-1][col2]
        }
        if col1 > 0 && row1 > 0 {
            ans += tbl[row1-1][col1-1]
        }
        return ans
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */
// @lc code=end


/*
 * @lc app=leetcode id=308 lang=swift
 *
 * [308] Range Sum Query 2D - Mutable
 */

//!!! - premium problem, not verified.

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class NumArray2 {
    private var bit2: BinaryIndexTree2

    init(_ matrix: [[Int]]) {
        bit2 = BinaryIndexTree2(matrix)
    }

    func update(_ row: Int, _ col: Int, _ val: Int) {
        bit2.update(row, col, val)
    }

    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        return bit2.query(row1, col1, row2, col2)
    }
}

fileprivate class BinaryIndexTree2 {
    private var matrix: [[Int]]
    private var bit: [[Int]]
    private var m: Int = 0
    private var n: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
    }

    init(_ matrix: [[Int]]) {
        m = matrix.count
        n = matrix[0].count
        self.matrix = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        bit = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        for i in 0..<m {
            for j in 0..<n {
                update(i, j, matrix[i][j])
            }
        }
    }

    func update(_ row: Int, _ col: Int, _ val: Int) {
        let diff = val - matrix[row+1][col+1]
        var i = row + 1
        while i <= m {
            var j = col + 1
            while j <= n {
                bit[i][j] += diff
                j += lowbit(j)
            }
            i += lowbit(i)
        }
        matrix[row+1][col+1] = val
    }

    func query(_ row: Int, _ col: Int) -> Int {
        guard (0..<m).contains(row) && (0..<n).contains(col) else { return 0 }
        var ans = 0
        var i = row + 1
        while i > 0 {
            var j = col + 1
            while j > 0 {
                ans += bit[i][j]
                j -= lowbit(j)
            }
            i -= lowbit(i)
        }
        return ans
    }

    func query(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        return query(row2, col2) - query(row1 - 1, col2) - query(row2, col1 - 1) + query(row1 - 1, col1 - 1)
    }
}
// @lc code=end

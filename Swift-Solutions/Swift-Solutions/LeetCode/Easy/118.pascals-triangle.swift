/*
 * @lc app=leetcode id=118 lang=swift
 *
 * [118] Pascal's Triangle
 */

// @lc code=start
extension Solution {
    func generate(_ numRows: Int) -> [[Int]] {
        if numRows == 1 {
            return [[1]]
        } else if numRows == 2 {
            return [[1], [1,1]]
        } else {
            var ans = [[1], [1,1]]
            for i in 3...numRows {
                let last = ans.last!
                var now = [Int](repeating: 1, count: i)
                for j in 1..<i-1 {
                    now[j] = last[j-1] + last[j]
                }
                ans.append(now)
            }
            return ans
        }
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=120 lang=swift
 *
 * [120] Triangle
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        var dp = [Int](repeating: Int.max, count: n * (n + 1) / 2)
        dp[0] = triangle[0][0]
        for i in 1..<n {
            for j in 0...i {
                let idx = i * (i + 1) / 2 + j
                if j == 0 {
                    dp[idx] = dp[idx-i]
                } else if j == i {
                    dp[idx] = dp[idx-i-1]
                } else {
                    dp[idx] = min(dp[idx-i-1], dp[idx-i])
                }
                dp[idx] += triangle[i][j]
            }
        }
        var ans = Int.max
        let lastRow = (n-1)*n/2..<(n+1)*n/2
        for i in lastRow {
            ans = min(ans, dp[i])
        }
        return ans
    }
}
// @lc code=end


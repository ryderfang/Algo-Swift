/*
 * @lc app=leetcode id=712 lang=swift
 *
 * [712] Minimum ASCII Delete Sum for Two Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minimumDeleteSum(_ s1: String, _ s2: String) -> Int {
        let s1 = Array(s1).map { $0.ascii() }
        let n1 = s1.count
        let s2 = Array(s2).map { $0.ascii() }
        let n2 = s2.count
        // dp[i][j] -> s1[i:] with s2[j:]
        var dp = [[Int]](repeating: [Int](repeating: Int.max, count: n2 + 1), count: n1 + 1)
        dp[n1][n2] = 0
        for i in stride(from: n1-1, through: 0, by: -1) {
            dp[i][n2] = s1[i] + dp[i+1][n2]
        }
        for j in stride(from: n2-1, through: 0, by: -1) {
            dp[n1][j] = s2[j] + dp[n1][j+1]
        }
        for i in stride(from: n1 - 1, through: 0, by: -1) {
            for j in stride(from: n2 - 1, through: 0, by: -1) {
                dp[i][j] = min(dp[i][j], dp[i+1][j] + s1[i],
                               dp[i][j+1] + s2[j],
                               dp[i+1][j+1] + (s1[i] == s2[j] ? 0 : s1[i] + s2[j]))

            }
        }
        return dp[0][0]
    }
}

private extension Character {
    func ascii() -> Int {
        guard let ascii = self.asciiValue, 97...122 ~= ascii else { return -1 }
        return Int(ascii)
    }
}
// @lc code=end


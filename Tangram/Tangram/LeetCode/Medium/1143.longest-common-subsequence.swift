/*
 * @lc app=leetcode id=1143 lang=swift
 *
 * [1143] Longest Common Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let n1 = text1.count
        let n2 = text2.count
        guard n1 > 0 && n2 > 0 else { return 0 }
        let a = Array(text1), b = Array(text2)
        var ans = 0
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n2 + 1), count: n1 + 1)
        for i in 1...n1 {
            for j in 1...n2 {
                dp[i][j] = (a[i-1] == b[j-1]) ? dp[i-1][j-1] + 1 : max(dp[i-1][j], dp[i][j-1])
                ans = max(ans, dp[i][j])
            }
        }
        return ans
    }

    func longestCommonSubsequence1(_ text1: String, _ text2: String) -> Int {
        let text1 = Array(text1)
        let text2 = Array(text2)
        let n1 = text1.count
        let n2 = text2.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n2), count: n1)
        for i in 0..<n1 {
            for j in 0..<n2 {
                if i > 0 && j > 0 {
                    dp[i][j] = max(dp[i][j], dp[i-1][j-1] + (text1[i] == text2[j] ? 1 : 0))
                }
                if i > 0 {
                    dp[i][j] = max(dp[i][j], dp[i-1][j])
                }
                if j > 0 {
                    dp[i][j] = max(dp[i][j], dp[i][j-1])
                }
                if i == 0 || j == 0 {
                    dp[i][j] = max(dp[i][j], (text1[i] == text2[j] ? 1 : 0))
                }
            }
        }
        return dp[n1-1][n2-1]
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=516 lang=swift
 *
 * [516] Longest Palindromic Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func longestPalindromeSubseq(_ s: String) -> Int {
        let s = Array(s)
        let n = s.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
        for k in 0..<n {
            for i in 0..<n {
                guard k > 0 else {
                    dp[i][i+k] = 1
                    continue
                }
                guard i + k < n else { continue }
                dp[i][i+k] = max(dp[i][i+k], dp[i][i+k-1], dp[i+1][i+k],
                                 (s[i] == s[i+k] ? dp[i+1][i+k-1] + 2 : dp[i+1][i+k-1]))
                
            }
        }
        return dp[0][n-1]
    }
}
// @lc code=end


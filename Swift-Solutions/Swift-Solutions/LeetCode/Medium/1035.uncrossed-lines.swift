/*
 * @lc app=leetcode id=1035 lang=swift
 *
 * [1035] Uncrossed Lines
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxUncrossedLines(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let (n1, n2) = (nums1.count, nums2.count)
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n2), count: n1)
        for i in 0..<n1 {
            for j in 0..<n2 {
                if i > 0 {
                    dp[i][j] = max(dp[i][j], dp[i-1][j])
                }
                if j > 0 {
                    dp[i][j] = max(dp[i][j], dp[i][j-1])
                }
                if nums1[i] == nums2[j] {
                    if i > 0 && j > 0 {
                        dp[i][j] = max(dp[i][j], dp[i-1][j-1] + 1)
                    } else {
                        dp[i][j] = 1
                    }
                }
            }
        }
        return dp[n1-1][n2-1]
    }
}
// @lc code=end


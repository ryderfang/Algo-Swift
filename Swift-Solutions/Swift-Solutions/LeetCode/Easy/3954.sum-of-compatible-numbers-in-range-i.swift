/*
 * @lc app=leetcode id=3954 lang=swift
 *
 * [3954] Sum of Compatible Numbers in Range I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // [max(n - k, 0), n + k]
    // dp[n][0] = 0
    // dp[n][k] = dp[n][k-1] + (n - k)? + (n + k)?
    func sumOfGoodIntegers(_ n: Int, _ k: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 101), count: 101)
        for i in 1..<101 {
            for j in 1..<101 {
                dp[i][j] = dp[i][j-1]
                if i >= j {
                    if i & (i - j) == 0 {
                        dp[i][j] += (i - j)
                    }
                }
                if i & (i + j) == 0 {
                    dp[i][j] += (i + j)
                }
            }
        }
        return dp[n][k]
    }
}
// @lc code=end


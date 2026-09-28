/*
 * @lc app=leetcode id=72 lang=swift
 *
 * [72] Edit Distance
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution:
    /*
     dp[i][0] = i
     dp[0][j] = j
     if arr1[i-1] == arr2[j-1]
        dp[i][j] = dp[i - 1][j - 1]
     else
        dp[i][j] = 1 + min(dp[i][j - 1], dp[i - 1][j], dp[i - 1][j - 1])
     */
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let n1 = word1.count
        let n2 = word2.count
        guard n1 > 0 && n2 > 0 else { return max(n1, n2) }
        let arr1 = Array(word1)
        let arr2 = Array(word2)
        var dp = [[Int]](repeating: [Int](repeating: Int.max, count: n2), count: n1)
        var flag = false
        for i in 0..<n1 {
            if flag {
                dp[i][0] = i
                continue
            }
            if arr1[i] == arr2[0] {
                dp[i][0] = i
                flag = true
            } else {
                dp[i][0] = i + 1
            }
        }
        flag = false
        for j in 0..<n2 {
            if flag {
                dp[0][j] = j
                continue
            }
            if arr1[0] == arr2[j] {
                dp[0][j] = j
                flag = true
            } else {
                dp[0][j] = j + 1
            }
        }
        for j in 1..<n2 {
            for i in 1..<n1 {
                dp[i][j] = min(dp[i][j], dp[i][j-1] + 1)
                dp[i][j] = min(dp[i][j], dp[i-1][j] + 1)
                if arr1[i] == arr2[j] {
                    dp[i][j] = min(dp[i][j], dp[i-1][j-1])
                } else {
                    dp[i][j] = min(dp[i][j], dp[i-1][j-1] + 1)
                }
            }
        }
        return dp[n1-1][n2-1]
    }
}
// @lc code=end


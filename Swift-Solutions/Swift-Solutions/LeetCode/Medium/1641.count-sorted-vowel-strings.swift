/*
 * @lc app=leetcode id=1641 lang=swift
 *
 * [1641] Count Sorted Vowel Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // a e i o u
    // n 个数排成 m 位
    // f(n, m) = 1 + f(n-1, m) + ∑f(n-1, i) // i <- [1, m-1]
    func countVowelStrings(_ n: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: 6)
        for i in 1...5 {
            dp[i][1] = i
        }
        for j in 1...n {
            dp[1][j] = 1
        }
        guard n > 1 else { return 5 }
        for i in 2...5 {
            for j in 2...n {
                dp[i][j] = dp[i-1][j] + 1
                for k in 1..<j {
                    dp[i][j] += dp[i-1][k]
                }
            }
        }
        return dp[5][n]
    }

    // Better solution
    func countVowelStrings1(_ n: Int) -> Int {
        (n + 4) * (n + 3) * (n + 2) * (n + 1) / 24
        /*
        var a = 1, e = 1, i = 1, o = 1, u = 1
        for j in 1..<n{
            a = (a+e+i+o+u)
            e = (e+i+o+u)
            i = (i+o+u)
            o = (o+u)
        }
        return (a+e+i+o+u)
        */
    }
}
// @lc code=end


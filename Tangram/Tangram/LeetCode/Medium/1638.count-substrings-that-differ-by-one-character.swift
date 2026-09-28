/*
 * @lc app=leetcode id=1638 lang=swift
 *
 * [1638] Count Substrings That Differ by One Character
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func countSubstrings(_ s: String, _ t: String) -> Int {
        let s = Array(s)
        let t = Array(t)
        let m = s.count
        let n = t.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        var sm = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                if s[i] == t[j] {
                    sm[i][j] = (i > 0 && j > 0) ? sm[i-1][j-1] + 1 : 1
                    dp[i][j] += (i > 0 && j > 0) ? dp[i-1][j-1] : 0
                } else {
                    // +1: add (s[i], t[j])
                    dp[i][j] += (i > 0 && j > 0) ? sm[i-1][j-1] + 1 : 1
                }
                ans += dp[i][j]
            }
        }
        return ans
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=3857 lang=swift
 *
 * [3857] Minimum Cost to Split into Ones
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    // 1 + 2 + ... + (n - 1)
    func minCost(_ n: Int) -> Int {
        n * (n - 1) / 2
    }
    
    func minCost1(_ n: Int) -> Int {
        let maxn = 501
        var dp = [Int](repeating: 0, count: maxn)
        dp[2] = 1
        for i in 3..<maxn {
            var tmp = Int.max
            for j in 1...(i/2) {
                tmp = min(tmp, j * (i - j) + dp[j] + dp[i-j])
            }
            dp[i] = tmp
        }
        return dp[n]
    }
}
// @lc code=end

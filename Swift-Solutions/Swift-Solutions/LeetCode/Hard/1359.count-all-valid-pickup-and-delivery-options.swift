/*
 * @lc app=leetcode id=1359 lang=swift
 *
 * [1359] Count All Valid Pickup and Delivery Options
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // p1 d1
    // p2 d2 = 3 + 2 + 1 (insert positions)
    // p3 d3 = (5 + 4 + 3 + 2 + 1) * dp[2]
    func countOrders(_ n: Int) -> Int {
        let mod = Int(1e9 + 7)
        // 1 + ... + (n - 1) * 2 + 1
        var dp = [Int](repeating: 1, count: n + 1)
        for i in 1...n {
            dp[i] = (((dp[i-1] * i) % mod) * (2 * i - 1)) % mod
        }
        return dp[n]
    }
}
// @lc code=end

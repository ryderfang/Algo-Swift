/*
 * @lc app=leetcode id=935 lang=swift
 *
 * [935] Knight Dialer
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func knightDialer(_ n: Int) -> Int {
        // 04, 06, 16, 18, 27, 29, 34, 38, 40, 43, 49, 60, 61, 67, 72, 76, 81, 83, 92, 94
        let mp = [[4, 6], [6, 8], [7, 9], [4, 8], [0, 3, 9], [], [0, 1, 7], [2, 6], [1, 3], [2, 4]]
        let mod = Int(1e9 + 7)
        if n == 1 { return 10 }
        // result - start from num [i], and remain [j] nums
        var dp = [[Int]](repeating: [Int](repeating: Int.min, count: 5001), count: 10)
        for i in 0..<10 {
            dp[i][0] = 1
            dp[i][1] = mp[i].count
        }
        func _solve(_ i: Int, _ n: Int) -> Int {
            guard dp[i][n] == Int.min else { return dp[i][n] }
            var tmp = 0
            for k in mp[i] {
                tmp = (tmp % mod + _solve(k, n - 1) % mod) % mod
            }
            dp[i][n] = tmp % mod
            return dp[i][n]
        }
        var ans = 0
        for i in 0..<10 {
            ans = (ans % mod + _solve(i, n - 1) % mod) % mod
        }
        return ans % mod
    }
}
// @lc code=end


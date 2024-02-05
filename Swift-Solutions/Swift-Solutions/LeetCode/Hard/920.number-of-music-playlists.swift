/*
 * @lc app=leetcode id=920 lang=swift
 *
 * [920] Number of Music Playlists
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // MARK: review
    // 0 <= k < n <= goal <= 100
    func numMusicPlaylists(_ n: Int, _ goal: Int, _ k: Int) -> Int {
        let mod = Int(1e9 + 7)
        // dp[i][j] - 从 n 首歌中选 i 首不同的歌，组成长度 j 的歌单
        var dp = [[Int]](repeating: [Int](repeating: 0, count: goal + 1), count: n + 1)
        dp[0][0] = 1
        for j in 1...goal {
            for i in 1...min(n, j) {
                // 选一首新歌：不在 (i-1) 之中
                dp[i][j] = dp[i-1][j-1] * (n - (i - 1))
                // adding old songs, even though "k" should not be selected
                // 选一首老歌：i >= k 时，有 (i-k) 种选择
                dp[i][j] += dp[i][j - 1] * max(i - k, 0) % mod
                dp[i][j] %= mod
            }
        }
        return dp[n][goal]
    }
}
// @lc code=end

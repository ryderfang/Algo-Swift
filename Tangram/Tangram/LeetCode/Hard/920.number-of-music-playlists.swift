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
    // MARK: TODO
    // 0 <= k < n <= goal <= 100
    func numMusicPlaylists1(_ n: Int, _ goal: Int, _ k: Int) -> Int {
        let mod = Int(1e9 + 7)
        // dp[i][j] - 从 n 首歌中选 i 首不同的歌，组成长度 j 的歌单
        var dp = [[Int]](repeating: [Int](repeating: 0, count: goal + 1), count: n + 1)
        dp[0][0] = 1
        for i in 1...n {
            for j in i...goal {
                // 最后一首是新歌，有 (n - (i-1)) 种可能
                dp[i][j] = dp[i-1][j-1] * (n - (i - 1))
                // 最后一首是老歌，不能是最后的 k 首歌之一，所以是 (i - k) 种
                dp[i][j] += dp[i][j - 1] * max(i - k, 0) % mod
                dp[i][j] %= mod
            }
        }
        return dp[n][goal]
    }

    func numMusicPlaylists(_ n: Int, _ goal: Int, _ k: Int) -> Int {
        let mod = Int(1e9 + 7)
        var mem = [[Int]](repeating: [Int](repeating: -1, count: goal + 1), count: n + 1)
        func _dfs(_ n: Int, _ g: Int) -> Int {
            if n == 0 && g == 0 { return 1 }
            if n == 0 || g == 0 { return 0 }
            if mem[n][g] != -1 { return mem[n][g] }
            let a = _dfs(n - 1, g - 1) * n
            let b = _dfs(n, g - 1) * max(n - k, 0)
            mem[n][g] = (a + b) % mod
            return mem[n][g]
        }
        return _dfs(n, goal)
    }
}
// @lc code=end

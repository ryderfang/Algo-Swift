/*
 * @lc app=leetcode id=2400 lang=swift
 *
 * [2400] Number of Ways to Reach a Position After Exactly k Steps
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // dp[i][j] - count of diff "i", "j" step, i <= j
    // => 2 * dp[1][j-1] (i == 0)
    // => dp[i-1][j-1] + dp[i+1][j-1] (i > 0)
    func numberOfWays(_ startPos: Int, _ endPos: Int, _ k: Int) -> Int {
        let mod = Int(1e9 + 7)
        let diff = abs(startPos - endPos)
        guard diff <= k else { return 0 }
        var dp = [[Int]](repeating: [Int](repeating: 0, count: k + 1), count: k + 1)
        for i in 1...k {
            dp[i][i] = 1
        }
        for x in 1...k {
            for i in 0...k {
                let j = i + x
                guard j <= k else { break }
                if i == 0 {
                    dp[0][j] = (2 * dp[1][j-1]) % mod
                } else {
                    dp[i][j] = (dp[i+1][j-1] % mod + dp[i-1][j-1] % mod) % mod
                }
            }
        }
        return dp[diff][k]
    }

    // Another solution: dfs
    func numberOfWays1(_ startPos: Int, _ endPos: Int, _ k: Int) -> Int {
        var cache = [[Int]: Int]()
        func dfs(_ pos: Int, _ steps: Int) -> Int {
            if steps > k {return 0}
            if pos == endPos && steps == k {return 1}
            if let val = cache[[pos, steps]] {return val}
            
            let res = dfs(pos+1, steps+1) + dfs(pos-1, steps+1)
            cache[[pos, steps]] = res
            return res % Int(1e9+7)
        }
        return dfs(startPos, 0)
    }
}
// @lc code=end

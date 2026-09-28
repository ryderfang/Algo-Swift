/*
 * @lc app=leetcode id=1140 lang=swift
 *
 * [1140] Stone Game II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func stoneGameII(_ piles: [Int]) -> Int {
        let n = piles.count
        var preSum = [Int](repeating: 0, count: n)
        preSum[0] = piles[0]
        for i in 1..<n {
            preSum[i] = preSum[i-1] + piles[i]
        }

        func _sum(_ i: Int, _ j: Int) -> Int {
            guard j >= i else { return 0 }
            return preSum[j] - (i > 0 ? preSum[i-1] : 0)
        }

        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
        func _solve(_ i: Int, _ m: Int) -> Int {
            let m2 = min(2 * m, n - i)
            // x <- [1, 2m]
            if dp[i][m2] > 0 { return dp[i][m2] }
            if m2 == n - i {
                dp[i][m2] = _sum(i, n-1)
            } else {
                var ret = 0
                for k in 1...m2 {
                    // [i, i+k)
                    var tmp = _sum(i, i+k-1)
                    let x = max(k, m)
                    tmp += _sum(i+k, n-1) - _solve(i+k, x)
                    ret = max(ret, tmp)
                }
                dp[i][m2] = ret
            }
            return dp[i][m2]
        }
        let ans = _solve(0, 1)
        return ans
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=474 lang=swift
 *
 * [474] Ones and Zeroes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
        func _pack_05(_ V: Int, _ U: Int, _ C: [Int], _ D: [Int], _ W: [Int]) -> Int {
            let n = C.count
            var dp = Array(repeating: Array(repeating: 0, count: U + 1), count: V + 1)
            for i in 0..<n {
                guard C[i] <= V && D[i] <= U else { continue }
                for v in stride(from: V, through: C[i], by: -1) {
                    for u in stride(from: U, through: D[i], by: -1) {
                        dp[v][u] = max(dp[v][u], dp[v-C[i]][u-D[i]] + W[i])
                    }
                }
            }
            return dp[V][U]
        }
        
        // !! take care of argument is `n`
        let sz = strs.count
        var C_0 = [Int](repeating: 0, count: sz)
        var C_1 = [Int](repeating: 0, count: sz)
        for i in 0..<sz {
            let tmp = Array(strs[i])
            C_0[i] = tmp.filter({ $0 == "0" }).count
            C_1[i] = tmp.count - C_0[i]
        }
        let W = [Int](repeating: 1, count: sz)
        let ans = _pack_05(m, n, C_0, C_1, W)
        return ans
    }
}
// @lc code=end


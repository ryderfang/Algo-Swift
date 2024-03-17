/*
 * @lc app=leetcode id=1043 lang=swift
 *
 * [1043] Partition Array for Maximum Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
        let n = arr.count
        var dp = [Int](repeating: Int.min, count: n)
        dp[0] = arr[0]
        for i in stride(from: 1, to: n, by: 1) {
            // max of [i-j+1, i]
            var tmp = arr[i]
            for j in 1...min(k,i) {
                dp[i] = max(dp[i], dp[i-j] + j * tmp)
                tmp = max(tmp, arr[i-j])
            }
            // group [0, i]
            if i + 1 <= k {
                dp[i] = max(dp[i], (i + 1) * tmp)
            }
        }
        return dp[n-1]
    }
}
// @lc code=end

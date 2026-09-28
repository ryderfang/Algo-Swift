/*
 * @lc app=leetcode id=740 lang=swift
 *
 * [740] Delete and Earn
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func deleteAndEarn(_ nums: [Int]) -> Int {
        var mp = [Int: Int]()
        for x in nums {
            mp[x, default: 0] += 1
        }
        let sorted = mp.keys.sorted(by: <)
        let n = sorted.count
        var dp = [Int](repeating: 0, count: n)
        for i in 0..<n {
            let cur = sorted[i] * mp[sorted[i], default: 0]
            if i == 0 {
                dp[0] = cur
            } else {
                dp[i] = max(dp[i], dp[i-1])
                dp[i] = max(dp[i], cur)
                if sorted[i] == sorted[i-1] + 1 {
                    if i >= 2 {
                        dp[i] = max(dp[i], dp[i-2] + cur)
                    }
                } else {
                    dp[i] = max(dp[i], dp[i-1] + cur)
                }
            }
        }
        return dp[n-1]
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=2606 lang=swift
 *
 * [2606] Find the Substring With Maximum Cost
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maximumCostSubstring(_ s: String, _ chars: String, _ vals: [Int]) -> Int {
        var cost = [Character: Int]()
        for i in 1...26 {
            let ch = Character(UnicodeScalar(UInt8(i+96)))
            cost[ch] = i
        }
        for (i, ch) in chars.enumerated() {
            cost[ch] = vals[i]
        }
        let n = s.count
        let str = Array(s)
        // ans when end at i
        var dp = [Int](repeating: 0, count: n)
        for i in 0..<n {
            if i == 0 {
                dp[i] = max(dp[i], cost[str[i], default: 0])
            } else {
                dp[i] = max(dp[i], dp[i-1] + cost[str[i], default: 0], cost[str[i], default: 0])
            }
        }
        return dp.max() ?? 0
    }
}
// @lc code=end


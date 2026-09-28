/*
 * @lc app=leetcode id=646 lang=swift
 *
 * [646] Maximum Length of Pair Chain
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func findLongestChain(_ pairs: [[Int]]) -> Int {
        let sorted = pairs.sorted(by: {
            return ($0[0] < $1[0]) || ($0[0] == $1[0] && $0[1] < $1[1])
        })
        let n = pairs.count
        var dp = [Int](repeating: 0, count: n)
        for i in (0..<n).reversed() {
            var (j, maxRight) = (i + 1, 0)
            while j < n {
                if sorted[j][0] > sorted[i][1] {
                    maxRight = max(maxRight, dp[j])
                }
                j += 1
            }
            dp[i] = maxRight + 1
        }
        return dp.max() ?? 0
    }
}
// @lc code=end


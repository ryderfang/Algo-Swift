/*
 * @lc app=leetcode id=368 lang=swift
 *
 * [368] Largest Divisible Subset
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var sorted = nums.sorted(by: <)
        var dp = [[Int]](repeating: [Int](), count: n)
        dp[0] = [sorted[0]]
        var cnt = 1
        for i in 1..<n {
            var k = i
            for j in 0..<i {
                if sorted[i] % sorted[j] == 0 {
                    if dp[j].count + 1 > dp[k].count {
                        k = j
                    }
                }
            }
            dp[i] = dp[k] + [sorted[i]]
            cnt = max(cnt, dp[i].count)
        }
        for i in 0..<n {
            if dp[i].count == cnt {
                return dp[i]
            }
        }
        // not expected
        return []
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=983 lang=swift
 *
 * [983] Minimum Cost For Tickets
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
        let days = Set(days)
        var dp = Array(repeating: 0, count: 366)
        
        for i in 1...365 {
            if days.contains(i) {
                dp[i] = min(
                    dp[i - 1] + costs[0],
                    dp[max(0, i - 7)] + costs[1],
                    dp[max(0, i - 30)] + costs[2]
                )
            } else {
                dp[i] = dp[i - 1]
            }
        }

        return dp[365]
    }

    func mincostTickets1(_ days: [Int], _ costs: [Int]) -> Int {
        let (c1, c7, c30) = (costs[0], costs[1], costs[2])
        let maxDay = days.last!
        var valid = [Int](repeating: 0, count: maxDay + 1)
        for d in days {
            valid[d] = 1
        }
        var dp = [Int](repeating: Int.max, count: maxDay + 1)
        dp[0] = 0
        var ans = 0
        for i in 1...maxDay {
            dp[i] = min(dp[i], ans + c1)
            for j in 0..<7 {
                guard i + j <= maxDay else { break }
                dp[i+j] = min(dp[i+j], ans + c7)
            }
            for j in 0..<30 {
                guard i + j <= maxDay else { break }
                dp[i+j] = min(dp[i+j], ans + c30)
            }
            if valid[i] == 1 {
                ans = dp[i]
            }
        }
        return ans
    }
}
// @lc code=end


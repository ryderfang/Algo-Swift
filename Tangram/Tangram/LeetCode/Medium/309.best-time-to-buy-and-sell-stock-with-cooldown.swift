/*
 * @lc app=leetcode id=309 lang=swift
 *
 * [309] Best Time to Buy and Sell Stock with Cooldown
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // dp - O(n^2)
    func maxProfit(_ prices: [Int]) -> Int {
        let n = prices.count
        // ans[i] = max{dp[0...i]}
        var ans = [Int](repeating: 0, count: n)
        // dp[i] - max profit when sold at i
        var dp = [Int](repeating: 0, count: n)
        for i in 1..<n {
            var j = i - 1
            while j >= 0 {
                dp[i] = max(dp[i], (j >= 2 ? ans[j-2] : 0) + prices[i] - prices[j])
                j -= 1
            }
            ans[i] = max(ans[i-1], dp[i])
        }
        return ans[n-1]
    }

    // Better solution - O(n)
    func maxProfit3(_ prices: [Int]) -> Int {
        var reset = 0
        var held = Int.min
        var sold = Int.min

        for price in prices {
            let prevSold = sold

            sold = held + price
            held = max(reset - price, held)
            reset = max(reset, prevSold)
        }

        return max(reset, sold)
    }
}
// @lc code=end


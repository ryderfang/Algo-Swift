/*
 * @lc app=leetcode id=714 lang=swift
 *
 * [714] Best Time to Buy and Sell Stock with Transaction Fee
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // MARK: TODO
    // 1 <= n <= 5 * 10^4
    func maxProfit1(_ prices: [Int], _ fee: Int) -> Int {
        let n = prices.count
        guard n > 1 else { return 0 }
        var hold: (Int, Int)
        // sell at [i-1]
        var pre: Int = 0
        // sell at [i]
        var sell: Int = 0
        // (maxProfit, minPrice)
        hold = (0, prices[0])
        for i in 1..<n {
            sell = max(sell, hold.0 + prices[i] - hold.1 - fee)
            // !! update when profit gap > price gap
            if pre - hold.0 > prices[i] - hold.1 {
                hold = (pre, prices[i])
            }
            pre = sell
        }
        return max(hold.0, sell)
    }

    // Better solution
    func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
        var cash: Int = 0
        // hold a stock
        var hold: Int = -Int(1e10)
        for p in prices {
            cash = max(cash, hold + p - fee)
            hold = max(hold, cash - p)
        }
        return cash
    }

    // DP
    /*
     buy[0] = -prices[0]
     // keep the same as day i-1, or buy from sell status at day i-1
     buy[i] = Math.max(buy[i-1], sell[i-1] - prices[i])
     // keep the same as day i-1, or sell from buy status at day i-1
     sell[i] = Math.max(sell[i-1], buy[i-1] + prices[i] - fee)
     // selling on the last day is always more profitable than holding Lol.
     return sell[i-1]
    */
}
// @lc code=end

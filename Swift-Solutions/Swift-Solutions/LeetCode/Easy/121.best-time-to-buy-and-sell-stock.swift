/*
 * @lc app=leetcode id=121 lang=swift
 *
 * [121] Best Time to Buy and Sell Stock
 */

// @lc code=start
extension Solution {
    // f[i] = max(f[i-1], p[i] - minP[i-1])
    // optimize
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else { return 0 }
        let n = prices.count
        var minPrice = prices[0]
        var ans = 0
        for i in 1..<n {
            ans = max(ans, prices[i] - minPrice)
            minPrice = min(minPrice, prices[i])
        }
        return ans
    }

    func maxProfit1(_ prices: [Int]) -> Int {
        guard prices.count > 1 else { return 0 }
        let n = prices.count
        var minP = [Int](repeating: 0, count: n)
        minP[0] = prices[0]
        for i in 1..<n {
            minP[i] = min(minP[i-1], prices[i])
        }
        var f = [Int](repeating: 0, count: n)
        for i in 1..<n {
            f[i] = max(f[i-1], prices[i] - minP[i-1])
        }
        return f[n-1]
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=122 lang=swift
 *
 * [122] Best Time to Buy and Sell Stock II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        let n = prices.count
        guard n > 1 else { return 0 }
        var ans = 0
        for i in 1..<n {
            if prices[i] > prices[i-1] {
                ans += prices[i] - prices[i-1]
            }
        }
        return ans
    }
}
// @lc code=end


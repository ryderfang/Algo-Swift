/*
 * @lc app=leetcode id=441 lang=swift
 *
 * [441] Arranging Coins
 */

// @lc code=start
extension Solution {
    // x * (x + 1) / 2 <= n < (x + 1) * (x + 2) / 2
    func arrangeCoins(_ n: Int) -> Int {
        return Int(floor((sqrt(8.0 * Double(n) + 1) - 1) / 2))
    }
}
// @lc code=end


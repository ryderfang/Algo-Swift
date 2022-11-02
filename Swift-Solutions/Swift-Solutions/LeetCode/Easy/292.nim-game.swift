/*
 * @lc app=leetcode id=292 lang=swift
 *
 * [292] Nim Game
 */

// @lc code=start
extension Solution {
    // 1-3 first pick win
    // 4 first pick lose
    // 5-7 first pick 1~3 to make the second face 4-first situation, so win
    func canWinNim(_ n: Int) -> Bool {
        guard n % 4 == 0 else { return true }
        return false
    }
}
// @lc code=end


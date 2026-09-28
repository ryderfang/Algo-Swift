/*
 * @lc app=leetcode id=231 lang=swift
 *
 * [231] Power of Two
 */

// @lc code=start
extension Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        guard n > 0 else { return false }
        return (n & (n - 1)) == 0
    }
}
// @lc code=end


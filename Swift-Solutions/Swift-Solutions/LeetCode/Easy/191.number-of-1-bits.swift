/*
 * @lc app=leetcode id=191 lang=swift
 *
 * [191] Number of 1 Bits
 */

// @lc code=start
extension Solution {
    func hammingWeight(_ n: Int) -> Int {
        var ans = 0
        var num = n
        while num > 0 {
            if num & 1 > 0 {
                ans += 1
            }
            num >>= 1
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=693 lang=swift
 *
 * [693] Binary Number with Alternating Bits
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func hasAlternatingBits(_ n: Int) -> Bool {
        var isOne = (n & 1 == 1)
        var n = n >> 1
        while n > 0 {
            if isOne && (n & 1 == 0) {
                isOne = false
            } else if !isOne && (n & 1 == 1) {
                isOne = true
            } else {
                return false
            }
            n >>= 1
        }
        return true
    }
}
// @lc code=end


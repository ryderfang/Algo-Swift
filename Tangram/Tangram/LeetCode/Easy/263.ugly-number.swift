/*
 * @lc app=leetcode id=263 lang=swift
 *
 * [263] Ugly Number
 */

// @lc code=start
extension Solution {
    func isUgly(_ n: Int) -> Bool {
        guard n > 0 else { return false }
        if n == 1 {
            return true
        }
        // exponent
        var exp2 = 0
        var exp3 = 0
        var exp5 = 0
        var num = n
        while num > 1 {
            if num % 2 == 0 {
                exp2 += 1
                num /= 2
            } else if num % 3 == 0 {
                exp3 += 1
                num /= 3
            } else if num % 5 == 0 {
                exp5 += 1
                num /= 5
            } else {
                return false
            }
        }
        return true
    }
}
// @lc code=end


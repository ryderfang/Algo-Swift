/*
 * @lc app=leetcode id=258 lang=swift
 *
 * [258] Add Digits
 */

// @lc code=start
class Solution {
    // Cheater: num < 10 ? num : (num % 9 == 0 ? 9 : num % 9)
    func addDigits(_ num: Int) -> Int {
        func _next(_ n: Int) -> Int {
            var sum = 0
            var n = n
            while n > 0 {
                sum += n % 10
                n /= 10
            }
            return sum
        }
        var n = num
        while n >= 10 {
            n = _next(n)
        }
        return n
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=9 lang=swift
 *
 * [9] Palindrome Number
 */

// @lc code=start
import Foundation
extension Solution {
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        if x == 0 {
            return true
        }
        var r = Int(pow(Double(10), floor(log10(Double(x)))))
        var res = true
        var tmp = x
        while r >= 10 {
            if tmp / r != tmp % 10 {
                res = false
                break
            }
            tmp = (tmp % r) / 10
            r /= 100
        }
        return res
    }
}
// @lc code=end


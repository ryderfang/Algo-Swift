/*
 * @lc app=leetcode id=504 lang=swift
 *
 * [504] Base 7
 */

// @lc code=start
extension Solution {
    func convertToBase7(_ num: Int) -> String {
        guard num != 0 else { return "0" }
        var n = abs(num)
        let negative = num < 0
        var ans = ""
        while n > 0 {
            ans = String(n % 7) + ans
            n /= 7
        }
        if negative {
            ans = "-" + ans
        }
        return ans
    }
}
// @lc code=end


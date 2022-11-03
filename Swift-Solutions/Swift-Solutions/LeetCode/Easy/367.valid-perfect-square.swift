/*
 * @lc app=leetcode id=367 lang=swift
 *
 * [367] Valid Perfect Square
 */

// @lc code=start
extension Solution {
    // 完全平方数
    func isPerfectSquare(_ num: Int) -> Bool {
        // 46340^2 < 2^31-1 < 46341^2
        var l = 1, r = min(num, 46340)
        while l <= r {
            let m = l + (r - l) / 2
            let mm = m * m
            if mm == num {
                return true
            } else if mm < num {
                l = m + 1
            } else {
                r = m - 1
            }
        }
        return false
    }
}
// @lc code=end


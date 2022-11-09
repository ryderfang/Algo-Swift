/*
 * @lc app=leetcode id=476 lang=swift
 *
 * [476] Number Complement
 */

// @lc code=start
extension Solution {
    func findComplement(_ num: Int) -> Int {
        var n = 1
        while num >= n {
            n <<= 1
        }
        n -= 1
        return n ^ num
    }
}
// @lc code=end


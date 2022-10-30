/*
 * @lc app=leetcode id=136 lang=swift
 *
 * [136] Single Number
 */

// @lc code=start
extension Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var ans = 0
        for x in nums {
            ans ^= x
        }
        return ans
    }
}
// @lc code=end


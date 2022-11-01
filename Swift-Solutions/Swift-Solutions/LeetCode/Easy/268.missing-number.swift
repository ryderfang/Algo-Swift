/*
 * @lc app=leetcode id=268 lang=swift
 *
 * [268] Missing Number
 */

// @lc code=start
extension Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        let n = nums.count
        let target = n * (n + 1) / 2
        let sum = nums.reduce(0, +)
        return target - sum
    }
}
// @lc code=end


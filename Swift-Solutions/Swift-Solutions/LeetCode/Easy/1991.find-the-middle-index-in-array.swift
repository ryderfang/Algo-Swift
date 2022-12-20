/*
 * @lc app=leetcode id=1991 lang=swift
 *
 * [1991] Find the Middle Index in Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findMiddleIndex(_ nums: [Int]) -> Int {
        let sum = nums.reduce(0, +)
        var count = 0
        for i in 0..<nums.count {
            if count == (sum - count - nums[i]) {
                return i
            }
            count += nums[i]
        }
        return -1
    }
}
// @lc code=end


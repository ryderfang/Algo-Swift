/*
 * @lc app=leetcode id=2221 lang=swift
 *
 * [2221] Find Triangular Sum of an Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func triangularSum(_ nums: [Int]) -> Int {
        var n = nums.count
        var nums = nums
        while n > 1 {
            n -= 1
            for i in 0..<n {
                nums[i] = (nums[i] + nums[i+1]) % 10
            }
        }
        return nums[0]
    }
}
// @lc code=end


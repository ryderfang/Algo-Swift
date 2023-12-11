/*
 * @lc app=leetcode id=396 lang=swift
 *
 * [396] Rotate Function
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maxRotateFunction(_ nums: [Int]) -> Int {
        let sum = nums.reduce(0, +)
        let n = nums.count
        var ans = Int.min
        var last = 0
        for i in 0..<n {
            last += i * nums[i]
        }
        ans = max(ans, last)
        for i in 1..<n {
            last = last - sum + n * nums[i-1]
            ans = max(ans, last)
        }
        return ans
    }
}
// @lc code=end

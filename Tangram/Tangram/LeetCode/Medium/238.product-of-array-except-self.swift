/*
 * @lc app=leetcode id=238 lang=swift
 *
 * [238] Product of Array Except Self
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var ans = [Int](repeating: 1, count: n)
        for i in 1..<n {
            ans[i] = ans[i-1] * nums[i-1]
        }
        var t = nums[n-1]
        for i in 2...n {
            ans[n-i] = t * ans[n-i]
            t *= nums[n-i]
        }
        return ans
    }
}
// @lc code=end


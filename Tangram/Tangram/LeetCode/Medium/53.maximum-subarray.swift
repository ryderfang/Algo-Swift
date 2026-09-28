/*
 * @lc app=leetcode id=53 lang=swift
 *
 * [53] Maximum Subarray
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        var ans = Int.min, tmp = 0
        var s = 0, e = 0
        for i in 0..<nums.count {
            tmp += nums[i]
            if tmp > ans {
                ans = tmp
                e = i
            }
            if tmp <= 0 {
                tmp = 0
                s = i + 1
            }
        }
        print(s, e)
        return ans
    }
}
// @lc code=end


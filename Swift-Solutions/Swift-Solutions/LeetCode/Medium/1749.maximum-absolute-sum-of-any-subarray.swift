/*
 * @lc app=leetcode id=1749 lang=swift
 *
 * [1749] Maximum Absolute Sum of Any Subarray
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxAbsoluteSum(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return abs(nums[0] )}
        // hdu1003 maxSum
        func _maxSum(_ arr: [Int]) -> Int {
            let n = arr.count
            guard n > 1 else { return arr[0] }
            var tmp = 0
            var ans = 0
            for i in 0..<n {
                tmp += arr[i]
                ans = max(ans, tmp)
                if tmp < 0 {
                    tmp = 0
                }
            }
            return ans
        }
        let maxVal = _maxSum(nums)
        let minVal = -_maxSum(nums.map { -$0 })
        return max(abs(maxVal), abs(minVal))
    }
}
// @lc code=end


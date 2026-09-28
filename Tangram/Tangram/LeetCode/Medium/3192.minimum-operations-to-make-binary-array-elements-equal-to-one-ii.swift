/*
 * @lc app=leetcode id=3192 lang=swift
 *
 * [3192] Minimum Operations to Make Binary Array Elements Equal to One II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        var ret = 0
        for i in 0..<n {
            if nums[i] == 0 && (ret & 1 == 0) {
                // 0 翻转奇数次
                ret += 1
            } else if nums[i] == 1 && (ret & 1 == 1) {
                // 1 翻转偶数次
                ret += 1
            }
        }
        return ret
    }
}
// @lc code=end


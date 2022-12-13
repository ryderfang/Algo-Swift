/*
 * @lc app=leetcode id=561 lang=swift
 *
 * [561] Array Partition
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func arrayPairSum(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        var ans = 0
        for i in stride(from: 0, to: nums.count, by: 2) {
            ans += nums[i]
        }
        return ans
    }
}
// @lc code=end


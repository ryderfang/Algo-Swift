/*
 * @lc app=leetcode id=976 lang=swift
 *
 * [976] Largest Perimeter Triangle
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func largestPerimeter(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n >= 3 else { return 0 }
        let nums = nums.sorted(by: >)
        for i in 0..<n-2 {
            if nums[i+1] + nums[i+2] > nums[i] {
                return nums[i] + nums[i+1] + nums[i+2]
            }
        }
        return 0
    }
}
// @lc code=end


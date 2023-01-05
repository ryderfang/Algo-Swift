/*
 * @lc app=leetcode id=922 lang=swift
 *
 * [922] Sort Array By Parity II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func sortArrayByParityII(_ nums: [Int]) -> [Int] {
        var nums = nums
        var (even, odd) = (0, 1)
        let n = nums.count
        while even < n {
            while even < n && nums[even] % 2 == 0 {
                even += 2
            }
            while odd < n && nums[odd] % 2 == 1 {
                odd += 2
            }
            if even < n && odd < n {
                nums.swapAt(even, odd)
                even += 2
                odd += 2
            }
        }
        return nums
    }
}
// @lc code=end


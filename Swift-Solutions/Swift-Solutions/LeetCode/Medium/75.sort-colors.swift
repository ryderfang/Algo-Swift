/*
 * @lc app=leetcode id=75 lang=swift
 *
 * [75] Sort Colors
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func sortColors(_ nums: inout [Int]) {
        var n = nums.count
        guard n > 1 else { return }
        var i = 0
        while i < n {
            if nums[i] == 1 {
                i += 1
                continue
            }
            if nums[i] == 0 {
                nums.remove(at: i)
                nums.insert(0, at: 0)
                i += 1
                continue
            }
            if nums[i] == 2 {
                nums.remove(at: i)
                nums.append(2)
                n -= 1
                continue
            }
        }
    }
}
// @lc code=ender546


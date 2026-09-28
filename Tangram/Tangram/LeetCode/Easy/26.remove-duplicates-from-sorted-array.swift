/*
 * @lc app=leetcode id=26 lang=swift
 *
 * [26] Remove Duplicates from Sorted Array
 */

// @lc code=start
extension Solution {
    fileprivate func removeDuplicates(_ nums: inout [Int]) -> Int {
        var ret = nums.count
        var i = 0
        while i < ret {
            var j = i + 1
            while j < ret && nums[j] == nums[i] {
                j += 1
            }
            nums.removeSubrange(i+1..<j)
            ret -= (j - i - 1)
            i += 1
        }
        return ret
    }
}
// @lc code=end


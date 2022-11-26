/*
 * @lc app=leetcode id=80 lang=swift
 *
 * [80] Remove Duplicates from Sorted Array II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var n = nums.count
        guard n > 1 else { return 1 }
        var cnt = 1
        var i = 1
        while i < n {
            if nums[i] == nums[i-1] {
                cnt += 1
                if cnt > 2 {
                    nums.remove(at: i)
                    cnt -= 1
                    n -= 1
                } else {
                    i += 1
                }
            } else {
                cnt = 1
                i += 1
            }
        }
        return n
    }
}
// @lc code=end


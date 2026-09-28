/*
 * @lc app=leetcode id=704 lang=swift
 *
 * [704] Binary Search
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = l + (r - l) / 2
            if nums[mid] == target {
                return mid
            }
            if nums[mid] < target {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return -1
    }
}
// @lc code=end


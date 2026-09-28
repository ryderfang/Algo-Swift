/*
 * @lc app=leetcode id=81 lang=swift
 *
 * [81] Search in Rotated Sorted Array II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func search1(_ nums: [Int], _ target: Int) -> Bool {
        let n = nums.count
        var l = 0, r = n - 1
        while l <= r {
            while l < r && nums[l] == nums[l+1] {
                l += 1
            }
            while r > l && nums[r] == nums[r-1] {
                r -= 1
            }

            let m = l + (r - l) / 2
            if nums[m] == target {
                return true
            }
            if l > r {
                break
            }

            let setL: () -> Void = {
                l = m + 1
            }
            let setR: () -> Void = {
                r = m - 1
            }
            if nums[m] >= nums[l] {
                // 左半区
                nums[l] <= target && target < nums[m] ? setR() : setL()
            } else {
                // 右半区
                nums[m] < target && target <= nums[r] ? setL() : setR()
            }
        }
        return false
    }
}
// @lc code=end


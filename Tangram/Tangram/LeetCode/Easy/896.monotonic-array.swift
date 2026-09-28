/*
 * @lc app=leetcode id=896 lang=swift
 *
 * [896] Monotonic Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isMonotonic(_ nums: [Int]) -> Bool {
        var ans: Bool? = nil
        var pre = nums[0]
        for x in nums {
            if x == pre {
                continue
            }
            if ans == nil {
                ans = x > pre ? true : false
            } else {
                guard ans == (x > pre) else { return false }
            }
            pre = x
        }
        return true
    }
}
// @lc code=end


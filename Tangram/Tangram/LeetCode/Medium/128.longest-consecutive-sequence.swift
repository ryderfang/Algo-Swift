/*
 * @lc app=leetcode id=128 lang=swift
 *
 * [128] Longest Consecutive Sequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        let n = nums.count
        guard n > 1 else { return n }
        var ans = 0, tmp = 1
        for i in 1..<n {
            if nums[i] == nums[i-1] {
                continue
            }
            if nums[i] == nums[i-1] + 1 {
                tmp += 1
            } else {
                ans = max(ans, tmp)
                tmp = 1
            }
        }
        ans = max(ans, tmp)
        return ans
    }
}
// @lc code=end


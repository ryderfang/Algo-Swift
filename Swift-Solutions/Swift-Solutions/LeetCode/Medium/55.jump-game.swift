/*
 * @lc app=leetcode id=55 lang=swift
 *
 * [55] Jump Game
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func canJump(_ nums: [Int]) -> Bool {
        var ans = 0
        for (i, x) in nums.dropLast().enumerated() {
            guard ans >= i else { break }
            ans = max(ans, i + x)
        }
        return ans >= nums.count - 1
    }
}
// @lc code=end


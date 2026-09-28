/*
 * @lc app=leetcode id=1911 lang=swift
 *
 * [1911] Maximum Alternating Subsequence Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxAlternatingSum(_ nums: [Int]) -> Int {
        let n = nums.count
        typealias _pair = (odd: Int, even: Int)
        var ans: _pair = (0, 0)
        for i in 0..<n {
            if i == 0 {
                ans.odd = nums[0]
            } else {
                ans.odd = max(ans.odd, ans.even + nums[i])
                ans.even = max(ans.even, ans.odd - nums[i])
            }
        }
        return max(ans.odd, ans.even)
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=3 lang=swift
 *
 * [3] Longest Substring Without Repeating Characters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // subsequence - 子序列，不要求连续
    // substring - 子串，必须是连续的
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var mp = [Character: Int]()
        var ans = 0, start = 0
        for (i, ch) in s.enumerated() {
            if let last = mp[ch] {
                ans = max(ans, i - start)
                start = max(start, last + 1)
            }
            mp[ch] = i
        }
        ans = max(ans, s.count - start)
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=521 lang=swift
 *
 * [521] Longest Uncommon Subsequence I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findLUSlength(_ a: String, _ b: String) -> Int {
        guard a != b else { return -1 }
        return max(a.count, b.count)
    }
}
// @lc code=end


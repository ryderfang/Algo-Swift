/*
 * @lc app=leetcode id=557 lang=swift
 *
 * [557] Reverse Words in a String III
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func reverseWords(_ s: String) -> String {
        return s.components(separatedBy: " ")
            .map { String($0.reversed()) }
            .joined(separator: " ")
    }
}
// @lc code=end


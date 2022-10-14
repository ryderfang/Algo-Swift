/*
 * @lc app=leetcode id=14 lang=swift
 *
 * [14] Longest Common Prefix
 */

// @lc code=start
extension Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard var ret = strs.first else { return "" }
        for s in strs.dropFirst() {
            while !s.hasPrefix(ret) {
                ret.removeLast()
            }
        }
        return ret
    }
}
// @lc code=end


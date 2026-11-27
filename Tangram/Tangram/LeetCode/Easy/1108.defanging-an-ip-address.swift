/*
 * @lc app=leetcode id=1108 lang=swift
 *
 * [1108] Defanging an IP Address
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func defangIPaddr(_ address: String) -> String {
        return address.replacingOccurrences(of: ".", with: "[.]")
    }
}
// @lc code=end

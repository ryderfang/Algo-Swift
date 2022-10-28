/*
 * @lc app=leetcode id=125 lang=swift
 *
 * [125] Valid Palindrome
 */

// @lc code=start
class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let alpha = s.map { ch in
            if ("a"..."z").contains(ch) || ("A"..."Z").contains(ch) ||
                ("0"..."9").contains(ch) {
                return String(ch).lowercased()
            } else {
                return ""
            }
        }.joined()
        print(alpha)
        return alpha == String(alpha.reversed())
    }
}
// @lc code=end


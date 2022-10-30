/*
 * @lc app=leetcode id=242 lang=swift
 *
 * [242] Valid Anagram
 */

// @lc code=start
extension Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        return s.sorted() == t.sorted()
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=824 lang=swift
 *
 * [824] Goat Latin
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func toGoatLatin(_ sentence: String) -> String {
        return sentence
            .components(separatedBy: " ")
            .enumerated()
            .map { (i, word) in
                var w = Array(word)
                guard let first = w.first else { return "" }
                var ans = word + "ma"
                if !["a", "e", "i", "o", "u"].contains(String(first).lowercased()) {
                    w.removeFirst()
                    w.append(first)
                    ans = String(w) + "ma"
                }
                ans += String([Character](repeating: "a", count: i + 1))
                return ans
            }
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=2063 lang=swift
 *
 * [2063] Vowels of All Substrings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countVowels(_ word: String) -> Int {
        func _isVowel(_ ch: Character) -> Bool {
            ["a", "e", "i", "o", "u"].contains(ch)
        }
        let n = word.count
        var ans = 0
        for (i, ch) in word.enumerated() {
            if _isVowel(ch) {
                ans += (n - i) * (i + 1)
            }
        }
        return ans
    }
}
// @lc code=end


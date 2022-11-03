/*
 * @lc app=leetcode id=345 lang=swift
 *
 * [345] Reverse Vowels of a String
 */

// @lc code=start
extension Solution {
    func reverseVowels(_ s: String) -> String {
        var s = s.map { String($0) }
        let n = s.count
        var i = 0, j = n - 1
        let isVowel: (String) -> Bool = {
            ["a", "e", "i", "o", "u"].contains($0.lowercased())
        }
        while i < j {
            while i < j && !isVowel(s[i]) {
                i += 1
            }
            while j > i && !isVowel(s[j]) {
                j -= 1
            }
            if i < j {
                s.swapAt(i, j)
                i += 1
                j -= 1
            }
        }
        return s.joined()
    }
}
// @lc code=end


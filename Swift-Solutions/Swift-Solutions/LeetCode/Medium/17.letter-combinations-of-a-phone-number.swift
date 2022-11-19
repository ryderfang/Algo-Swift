/*
 * @lc app=leetcode id=17 lang=swift
 *
 * [17] Letter Combinations of a Phone Number
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    private var phone_number: [String: String] {
        [ "2": "abc",
          "3": "def",
          "4": "ghi",
          "5": "jkl",
          "6": "mno",
          "7": "pqrs",
          "8": "tuv",
          "9": "wxyz"
        ]
    }
    func letterCombinations(_ digits: String) -> [String] {
        let n = digits.count
        guard n > 0 else { return [] }
        let firstChar = String(digits[digits.startIndex])
        guard let letters = phone_number[firstChar] else { return [] }
        var ans = [String]()
        var dropFirst = letterCombinations(String(digits.dropFirst()))
        if dropFirst.count == 0 {
            dropFirst.append("")
        }
        for ch in letters {
            ans.append(contentsOf: dropFirst.map { String(ch) + $0 })
        }
        return ans
    }
}
// @lc code=end


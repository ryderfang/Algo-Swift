/*
 * @lc app=leetcode id=58 lang=swift
 *
 * [58] Length of Last Word
 */

// @lc code=start
class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var flag = false
        var lastWord = ""
        for ch in s {
            if ch != " " {
                if flag {
                    lastWord = ""
                    flag = false
                }
                lastWord.append(ch)
            } else {
                flag = true
            }
        }
        return lastWord.count
    }
}
// @lc code=end


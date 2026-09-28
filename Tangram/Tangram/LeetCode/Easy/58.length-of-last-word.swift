/*
 * @lc app=leetcode id=58 lang=swift
 *
 * [58] Length of Last Word
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var lastWord = ""
        var flag = false
        for ch in s.reversed() {
            if ch != " " {
                flag = true
                lastWord.append(ch)
            } else {
                if flag {
                    break
                }
            }
        }
        print(String(lastWord.reversed()))
        return lastWord.count
    }
}
// @lc code=end


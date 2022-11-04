/*
 * @lc app=leetcode id=409 lang=swift
 *
 * [409] Longest Palindrome
 */

// @lc code=start
extension Solution {
    func longestPalindrome(_ s: String) -> Int {
        var mp = [Character: Int]()
        for ch in s {
            mp[ch, default: 0] += 1
        }
        var ans = 0
        var hasOdd = false
        for (_, v) in mp {
            ans += v
            if v & 1 > 0 {
                hasOdd = true
                ans -= 1
            }
        }
        if hasOdd {
            ans += 1
        }
        return ans
    }
}
// @lc code=end


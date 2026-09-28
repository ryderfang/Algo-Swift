/*
 * @lc app=leetcode id=680 lang=swift
 *
 * [680] Valid Palindrome II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func validPalindrome(_ s: String) -> Bool {
        let s = s.map { String($0) }
        let n = s.count
        guard n > 1 else { return true }
        var i = 0, j = n - 1 - i
        func _isValid(_ l: Int, _ r: Int) -> Bool {
            var l = l, r = r
            while l < r {
                guard s[l] == s[r] else { return false }
                l += 1
                r -= 1
            }
            return true
        }
        while i < j {
            if s[i] == s[j] {
                i += 1
                j -= 1
            } else {
                if s[i] == s[j-1] && _isValid(i+1, j-2) {
                    return true
                } else if s[i+1] == s[j] && _isValid(i+2, j-1) {
                    return true
                } else {
                    return false
                }
            }
        }
        return true
    }
}

// @lc code=end

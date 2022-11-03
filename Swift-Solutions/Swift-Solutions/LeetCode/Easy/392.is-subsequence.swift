/*
 * @lc app=leetcode id=392 lang=swift
 *
 * [392] Is Subsequence
 */

// @lc code=start
class Solution {
    // 非连续子串
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        let sz_s = s.count, sz_t = t.count
        var i = 0, j = 0
        while i < sz_s {
            let ch_s = s[s.index(s.startIndex, offsetBy: i)]
            while j < sz_t {
                let ch_t = t[t.index(t.startIndex, offsetBy: j)]
                if ch_s == ch_t {
                    break
                }
                j += 1
            }
            if j >= sz_t {
                return false
            }
            i += 1
            j += 1
        }
        return true
    }
}
// @lc code=end


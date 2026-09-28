/*
 * @lc app=leetcode id=844 lang=swift
 *
 * [844] Backspace String Compare
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func backspaceCompare(_ s: String, _ t: String) -> Bool {
        let s = Array(s), t = Array(t)
        let m = s.count, n = t.count
        var (i, j) = (m - 1, n - 1)
        var (bs1, bs2) = (0, 0)
        while i >= 0 || j >= 0 {
            while i >= 0 && (s[i] == "#" || bs1 > 0) {
                if s[i] == "#" {
                    bs1 += 1
                } else {
                    bs1 -= 1
                }
                i -= 1
            }

            while j >= 0 && (t[j] == "#" || bs2 > 0) {
                if t[j] == "#" {
                    bs2 += 1
                } else {
                    bs2 -= 1
                }
                j -= 1
            }

            if i == -1 && j == -1 {
                return true
            }

            guard i >= 0 && j >= 0 && s[i] == t[j] else { return false }
            i -= 1
            j -= 1
        }
        return true
    }
}
// @lc code=end


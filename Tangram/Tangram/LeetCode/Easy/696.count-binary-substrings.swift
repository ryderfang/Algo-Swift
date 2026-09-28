/*
 * @lc app=leetcode id=696 lang=swift
 *
 * [696] Count Binary Substrings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countBinarySubstrings(_ s: String) -> Int {
        let s = s.map { String($0) }
        let n = s.count
        guard n > 1 else { return 0 }
        var i = 1, ans = 0
        while i < n && s[i] == s[i-1] {
            i += 1
        }
        if i == n {
            return 0
        }
        var pre = i
        while i < n {
            var tmp = 1
            i += 1
            while i < n && s[i] == s[i-1] {
                i += 1
                tmp += 1
            }
            ans += min(pre, tmp)
            pre = tmp
        }
        return ans
    }
}
// @lc code=end


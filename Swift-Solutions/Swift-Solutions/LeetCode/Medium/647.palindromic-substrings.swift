/*
 * @lc app=leetcode id=647 lang=swift
 *
 * [647] Palindromic Substrings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 回文串
    func countSubstrings(_ s: String) -> Int {
        let s = Array(s)
        let n = s.count
        var mem = [[Int]: Bool]()
        var ans = 0
        func _isPalindromic(_ i: Int, _ j: Int) -> Bool {
            guard j >= i else { return false }
            if let cached = mem[[i, j]] {
                return cached
            }
            if i == j { return true }
            var ret = false
            if s[i] == s[j] {
                if i == j - 1 {
                    ret = true
                }
                if _isPalindromic(i+1, j-1) {
                    ret = true
                }
            }
            mem[[i, j]] = ret
            return ret
        }
        for i in 0..<n {
            for j in 0..<n {
                if _isPalindromic(i, j) {
                    ans += 1
                }
            }
        }
        return ans
    }
}
// @lc code=end

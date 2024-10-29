/*
 * @lc app=leetcode id=2002 lang=swift
 *
 * [2002] Maximum Product of the Length of Two Palindromic Subsequences
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // n <- [2, 12]
    func maxProduct(_ s: String) -> Int {
        let n = s.count
        let s = Array(s)
        var dp: [Array<Character>: Int] = [:]
        dp[[]] = 0
        func _maxPalindrome(_ t: Array<Character>, _ i: Int, _ j: Int) -> Int {
            guard i <= j else { return 0 }
            if i == j {
                return 1
            }
            var k = j
            while k > i {
                if t[k] == t[i] {
                    break
                }
                k -= 1
            }
            if k == i {
                return _maxPalindrome(t, i + 1, j)
            } else {
                return _maxPalindrome(t, i + 1, k - 1) + 2
            }
        }
        var ans = 0
        func _solve(_ i: Int, _ s1: Array<Character>, _ s2: Array<Character>) {
            if i == n {
                if dp[s1] == nil {
                    dp[s1] = _maxPalindrome(s1, 0, s1.count - 1)
                }
                if dp[s2] == nil {
                    dp[s2] = _maxPalindrome(s2, 0, s2.count - 1)
                }
                ans = max(ans, dp[s1, default: 0] * dp[s2, default: 0])
                return
            }
            _solve(i + 1, s1 + [s[i]], s2)
            _solve(i + 1, s1, s2 + [s[i]])
        }
        _solve(0, [], [])
        
        return ans
    }
}
// @lc code=end

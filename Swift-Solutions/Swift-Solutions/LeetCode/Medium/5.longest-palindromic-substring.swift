/*
 * @lc app=leetcode id=5 lang=swift
 *
 * [5] Longest Palindromic Substring
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func longestPalindrome(_ s: String) -> String {
        func _isPalindrome(_ s: String) -> Bool {
            return s == String(s.reversed())
        }

        let n = s.count
        guard n > 1 else { return s }
        if n == 2 {
            if s[0] == s[1] {
                return s
            } else {
                return String(s[0])
            }
        }
        var cnt = 1, ans = String(s[0])
        // odd
        for i in 1..<n-1 {
            var k = (cnt - 1) / 2
            if i <= k || n - 1 - i <= k {
                break
            }
            if _isPalindrome(s[i-k...i+k]) {
                k += 1
                while true {
                    if i - k < 0 || i + k >= n {
                        break
                    }
                    if s[i-k] != s[i+k] {
                        break
                    }
                    k += 1
                }
                cnt = (k - 1) * 2 + 1
                ans = s[i-k+1...i+k-1]
            }
        }
        var even = cnt + 1
        // even
        for i in 0..<n {
            if n - i < even {
                break
            }
            if _isPalindrome(s[i...i+even-1]) {
                var k = 1
                while true {
                    if i - k < 0 || (i+even-1+k) >= n {
                        break
                    }
                    if s[i-k] != s[i+even-1+k] {
                        break
                    }
                    k += 1
                }
                ans = s[i-k+1...i+even-1+k-1]
                even += 2 * (k - 1)
            }
        }
        print(cnt, even)
        cnt = max(cnt, even)
        return ans
    }
}

fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    subscript (r: ClosedRange<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)

        return String(self[start...end])
    }
}
// @lc code=end


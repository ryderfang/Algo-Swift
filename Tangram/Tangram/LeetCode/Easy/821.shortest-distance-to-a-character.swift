/*
 * @lc app=leetcode id=821 lang=swift
 *
 * [821] Shortest Distance to a Character
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func shortestToChar(_ s: String, _ c: Character) -> [Int] {
        let s = Array(s)
        let n = s.count
        var ans = [Int](repeating: Int.max, count: n)
        for (i, ch) in s.enumerated() {
            if ch == c {
                ans[i] = 0
                var j = i + 1
                while j < n && s[j] != c {
                    ans[j] = min(ans[j], j - i)
                    j += 1
                }
                j = i - 1
                while j >= 0 && s[j] != c {
                    ans[j] = min(ans[j], i - j)
                    j -= 1
                }
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=830 lang=swift
 *
 * [830] Positions of Large Groups
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func largeGroupPositions(_ s: String) -> [[Int]] {
        var ans = [[Int]]()
        let s = Array(s)
        var (st, ed) = (0, -1)
        var i = 0, n = s.count
        while i < n {
            if i == 0 || s[i] == s[i-1] {
                ed += 1
                if i == n - 1 && ed - st >= 2 {
                    ans.append([st, ed])
                }
            } else {
                if ed - st >= 2 {
                    ans.append([st, ed])
                }
                st = i
                ed = i
            }
            i += 1
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=1525 lang=swift
 *
 * [1525] Number of Good Ways to Split a String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func numSplits(_ s: String) -> Int {
        let s = Array(s)
        var mp1 = [Character: Int]()
        for c in s {
            mp1[c, default: 0] += 1
        }
        var cnt1 = mp1.count
        var mp2 = [Character: Int]()
        var cnt2 = 0
        var ans = 0
        for c in s {
            if mp1[c, default: 0] == 1 {
                cnt1 -= 1
            }
            if mp2[c, default: 0] == 0 {
                cnt2 += 1
            }
            if cnt1 == cnt2 {
                ans += 1
            }
            mp1[c, default: 0] -= 1
            mp2[c, default: 0] += 1
        }
        return ans
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=926 lang=swift
 *
 * [926] Flip String to Monotone Increasing
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // same as #1653
    func minFlipsMonoIncr(_ s: String) -> Int {
        let s = Array(s)
        let n = s.count
        var (cnt, ret) = (0, 0)
        for i in 0..<n {
            if s[i] == "1" {
                cnt += 1
            } else if cnt > 0 {
                cnt -= 1
                ret += 1
            }
        }
        return ret
    }
}
// @lc code=end


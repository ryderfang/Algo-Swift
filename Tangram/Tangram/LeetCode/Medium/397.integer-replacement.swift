/*
 * @lc app=leetcode id=397 lang=swift
 *
 * [397] Integer Replacement
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func integerReplacement(_ n: Int) -> Int {
        var t = n
        if t == 1 {
            return 0
        }
        if t & 1 == 0 {
            t >>= 1
            return 1 + integerReplacement(t)
        } else {
            return min(integerReplacement(t + 1), integerReplacement(t - 1)) + 1
        }
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=1009 lang=swift
 *
 * [1009] Complement of Base 10 Integer
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func bitwiseComplement(_ n: Int) -> Int {
        guard n > 0 else { return 1 }
        var x = 1
        while n >= x {
            x <<= 1
        }
        x -= 1
        return x ^ n
    }
}
// @lc code=end

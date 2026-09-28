/*
 * @lc app=leetcode id=717 lang=swift
 *
 * [717] 1-bit and 2-bit Characters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isOneBitCharacter(_ bits: [Int]) -> Bool {
        let n = bits.count
        var i = 0, ans = false
        while i < n {
            if bits[i] == 1 {
                i += 2
            } else {
                if i == n - 1 {
                    ans = true
                }
                i += 1
            }
        }
        return ans
    }
}
// @lc code=end


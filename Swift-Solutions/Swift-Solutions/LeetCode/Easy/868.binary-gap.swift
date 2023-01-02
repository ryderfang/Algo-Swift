/*
 * @lc app=leetcode id=868 lang=swift
 *
 * [868] Binary Gap
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func binaryGap(_ n: Int) -> Int {
        var cur = -1
        var n = n, ans = 0
        for i in 0..<32 {
            if n & 1 == 1 {
                if cur >= 0 {
                    ans = max(ans, i - cur)
                }
                cur = i
            }
            n >>= 1
        }
        return ans
    }
}
// @lc code=end


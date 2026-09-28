/*
 * @lc app=leetcode id=319 lang=swift
 *
 * [319] Bulb Switcher
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 找规律，只有 i^2 的数因子数才是奇数
    func bulbSwitch(_ n: Int) -> Int {
        let e = Int(floor(sqrt(Double(n))))
        return e
    }
}
// @lc code=end


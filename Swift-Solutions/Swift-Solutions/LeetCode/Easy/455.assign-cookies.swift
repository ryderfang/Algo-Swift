/*
 * @lc app=leetcode id=455 lang=swift
 *
 * [455] Assign Cookies
 */

// @lc code=start
extension Solution {
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        guard s.count > 0 else { return 0 }
        let g = g.sorted(by: >)
        let s = s.sorted(by: >)
        var i = 0, ans = 0
        for x in s {
            while i < g.count && g[i] > x {
                i += 1
            }
            if i < g.count {
                ans += 1
                i += 1
            }
        }
        return ans
    }
}
// @lc code=end


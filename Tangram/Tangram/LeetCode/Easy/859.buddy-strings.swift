/*
 * @lc app=leetcode id=859 lang=swift
 *
 * [859] Buddy Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func buddyStrings(_ s: String, _ goal: String) -> Bool {
        guard s.count == goal.count else { return false }
        let s = Array(s)
        let goal = Array(goal)
        let n = s.count
        var diff = [(Character, Character)]()
        var mp = [Character: Int]()
        for i in 0..<n {
            mp[s[i], default: 0] += 1
            if s[i] != goal[i] {
                diff.append((s[i], goal[i]))
            }
            if diff.count > 2 {
                return false
            }
        }
        if diff.count == 0 {
            return mp.count < n
        }
        if diff.count == 2 && diff[0].0 == diff[1].1 && diff[0].1 == diff[1].0 {
            return true
        }
        return false
    }
}
// @lc code=end


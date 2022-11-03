/*
 * @lc app=leetcode id=383 lang=swift
 *
 * [383] Ransom Note
 */

// @lc code=start
extension Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var mp = [Character: Int]()
        for ch in magazine {
            mp[ch, default: 0] += 1
        }
        for ch in ransomNote {
            if mp[ch, default: 0] == 0 {
                return false
            }
            mp[ch, default: 0] -= 1
        }
        return true
    }
}
// @lc code=end


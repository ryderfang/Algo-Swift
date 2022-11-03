/*
 * @lc app=leetcode id=389 lang=swift
 *
 * [389] Find the Difference
 */

// @lc code=start
extension Solution {
    // 可优化：字符串 -> 数字 -> 异或
    func findTheDifference(_ s: String, _ t: String) -> Character {
        var mp = [Character: Int]()
        for ch in t {
            mp[ch, default: 0] += 1
        }
        for ch in s {
            mp[ch, default: 0] -= 1
            if mp[ch, default: 0] <= 0 {
                mp[ch] = nil
            }
        }
        return mp.first!.key
    }
}
// @lc code=end


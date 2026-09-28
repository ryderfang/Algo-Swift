/*
 * @lc app=leetcode id=387 lang=swift
 *
 * [387] First Unique Character in a String
 */

// @lc code=start
extension Solution {
    func firstUniqChar(_ s: String) -> Int {
        var mp = [Character: Int]()
        for ch in s {
            mp[ch, default: 0] += 1
        }
        for (i, ch) in s.enumerated() {
            if mp[ch] == 1 {
                return i
            }
        }
        return -1
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=500 lang=swift
 *
 * [500] Keyboard Row
 */

// @lc code=start
extension Solution {
    func findWords(_ words: [String]) -> [String] {
        var mp = [Character: Int]()
        let keyboard = [
            "qwertyuiop",
            "asdfghjkl",
            "zxcvbnm",
        ]
        for (i, s) in keyboard.enumerated() {
            for ch in s {
                mp[ch] = i
            }
        }
        var ans = [String]()
        for w in words {
            guard w.count > 0 else { continue }
            let low = w.lowercased()
            let sentry = mp[low.first!]
            var check = true
            for ch in low.dropFirst() {
                guard mp[ch] == sentry else {
                    check = false
                    break
                }
            }
            if check {
                ans.append(w)
            }
        }
        return ans
    }
}
// @lc code=end


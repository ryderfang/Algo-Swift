/*
 * @lc app=leetcode id=748 lang=swift
 *
 * [748] Shortest Completing Word
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func shortestCompletingWord(_ licensePlate: String, _ words: [String]) -> String {
        var license = [String: Int]()
        for ch in licensePlate.lowercased() {
            guard ("a"..."z").contains(ch) else { continue }
            license[String(ch), default: 0] += 1
        }
        var ans = "", minLength = Int.max
        for str in words {
            var mp = [String: Int]()
            for ch in str.lowercased() {
                mp[String(ch), default: 0] += 1
            }
            var check = true
            for (k, v) in license {
                guard let count = mp[k] else {
                    check = false
                    break
                }
                if v == 1 || (v > 1 && count == v) {
                    continue
                } else {
                    check = false
                    break
                }
            }
            if check && str.count < minLength {
                minLength = str.count
                ans = str
            }
        }
        return ans
    }
}
// @lc code=end


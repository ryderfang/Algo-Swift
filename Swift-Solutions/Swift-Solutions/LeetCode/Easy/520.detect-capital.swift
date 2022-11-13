/*
 * @lc app=leetcode id=520 lang=swift
 *
 * [520] Detect Capital
 */

// @lc code=start
extension Solution {
    func detectCapitalUse(_ word: String) -> Bool {
        guard word.count > 0 else { return false }
        if word.uppercased() == word {
            return true
        }
        if word.lowercased() == word {
            return true
        }
        if ("A"..."Z").contains(word.first!) {
            let tail = word.dropFirst()
            return tail.lowercased() == tail
        }
        return false
    }
}
// @lc code=end


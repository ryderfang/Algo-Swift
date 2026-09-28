/*
 * @lc app=leetcode id=884 lang=swift
 *
 * [884] Uncommon Words from Two Sentences
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func uncommonFromSentences(_ s1: String, _ s2: String) -> [String] {
        var mp1 = [String: Int]()
        for w in s1.components(separatedBy: " ") {
            mp1[w, default: 0] += 1
        }
        var mp2 = [String: Int]()
        for w in s2.components(separatedBy: " ") {
            mp2[w, default: 0] += 1
        }
        let set1 = Set(mp1.filter { $0.value == 1 }.keys.filter { mp2[$0] == nil })
        let set2 = Set(mp2.filter { $0.value == 1 }.keys.filter { mp1[$0] == nil })
        return Array(set1.union(set2))
    }
}
// @lc code=end


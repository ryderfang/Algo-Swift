/*
 * @lc app=leetcode id=953 lang=swift
 *
 * [953] Verifying an Alien Dictionary
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        var mp = [Character: Int]()
        let order = Array(order)
        for (i, ch) in order.enumerated() {
            mp[ch] = i
        }
        let words = words.map { Array($0) }
        return words.sorted(by: { w1, w2 in
            let n1 = w1.count, n2 = w2.count
            var (i, j) = (0, 0)
            while i < n1 && j < n2 {
                if mp[w1[i]]! < mp[w2[j]]! {
                    return true
                } else if mp[w1[i]]! > mp[w2[j]]! {
                    return false
                }
                i += 1
                j += 1
            }
            return n1 < n2
        }) == words
    }
}
// @lc code=end


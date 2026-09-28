/*
 * @lc app=leetcode id=692 lang=swift
 *
 * [692] Top K Frequent Words
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var mp = [String: Int]()
        for w in words {
            mp[w, default: 0] += 1
        }
        let freq = mp.sorted(by: { $0.value > $1.value || ($0.value == $1.value && $0.key < $1.key )})
        return Array(freq.map({ $0.key }).prefix(k))
    }
}
// @lc code=end


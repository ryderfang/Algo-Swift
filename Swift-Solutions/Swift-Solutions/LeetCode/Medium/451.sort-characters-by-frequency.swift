/*
 * @lc app=leetcode id=451 lang=swift
 *
 * [451] Sort Characters By Frequency
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func frequencySort(_ s: String) -> String {
        var mp = [Character: Int]()
        for c in s {
            mp[c, default: 0] += 1
        }
        var sorted = mp.sorted(by: {$0.value > $1.value } )
        var ans = [Character]()
        for (ch, n) in sorted {
            ans.append(contentsOf: [Character](repeating: ch, count: n))
        }
        return String(ans)
    }
}
// @lc code=end


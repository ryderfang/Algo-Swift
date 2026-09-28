/*
 * @lc app=leetcode id=49 lang=swift
 *
 * [49] Group Anagrams
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var mp = [String: [String]]()
        for x in strs {
            let key = String(x.sorted())
            var value = mp[key, default: []]
            value.append(x)
            mp[key] = value
        }
        return [[String]](mp.values)
    }
}
// @lc code=end


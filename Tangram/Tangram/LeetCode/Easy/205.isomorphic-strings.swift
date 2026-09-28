/*
 * @lc app=leetcode id=205 lang=swift
 *
 * [205] Isomorphic Strings
 */

// @lc code=start
extension Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        var mp = [Character: Character]()
        let sa = [Character](s)
        let st = [Character](t)
        let n = s.count
        for i in 0..<n {
            if let ch = mp[sa[i]] {
                guard ch == st[i] else { return false }
            } else {
                guard !mp.values.contains(st[i]) else { return false }
                mp[sa[i]] = st[i]
            }
        }
        return true
    }
}
// @lc code=end


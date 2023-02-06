/*
 * @lc app=leetcode id=187 lang=swift
 *
 * [187] Repeated DNA Sequences
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findRepeatedDnaSequences(_ s: String) -> [String] {
        let n = s.count
        guard n > 10 else { return [] }
        let s = Array(s)
        var mp = [String: Int]()
        var sub = s[0..<10]
        for i in 10..<n {
            mp[String(sub), default: 0] += 1
            sub.removeFirst()
            sub.append(s[i])
        }
        mp[String(sub), default: 0] += 1
        return Array(mp.filter { $0.value > 1 }.keys)
    }
}
// @lc code=end

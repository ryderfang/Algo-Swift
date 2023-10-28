/*
 * @lc app=leetcode id=318 lang=swift
 *
 * [318] Maximum Product of Word Lengths
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: "abcw" -> "00100000000000000000000111", check common with `&`
    func maxProduct(_ words: [String]) -> Int {
        let n = words.count
        var mp = [Character: [Int]]()
        var arr = [(count: Int, chars: Set<Character>, common: Set<Int>)]()
        for (i, s) in words.enumerated() {
            let chars = Set<Character>(s)
            let count = s.count
            arr.append((count: count, chars: chars, common: []))
            for ch in chars {
                mp[ch, default: []].append(i)
            }
        }
        for i in 0..<n {
            var common = Set<Int>()
            for ch in arr[i].chars {
                common.formUnion(Set<Int>(mp[ch, default: []]))
            }
            arr[i].common = common
        }
        var ans = 0
        for i in 0..<n {
            let common = arr[i].common
            for j in i+1..<n {
                guard !common.contains(j) else { continue }
                ans = max(ans, arr[i].count * arr[j].count)
            }
        }
        return ans
    }
}
// @lc code=end


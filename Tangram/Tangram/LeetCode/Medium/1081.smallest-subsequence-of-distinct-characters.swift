/*
 * @lc app=leetcode id=1081 lang=swift
 *
 * [1081] Smallest Subsequence of Distinct Characters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func smallestSubsequence(_ s: String) -> String {
        var letters = [Character: Int]()
        for ch in s {
            letters[ch, default: 0] += 1
        }
        var ans = [Character]()
        var visited = Set<Character>()
        for ch in s {
            letters[ch, default: 0] -= 1
            guard !visited.contains(ch) else { continue }
            while let last = ans.last, last > ch, letters[last, default: 0] > 0 {
                ans.removeLast()
                visited.remove(last)
            }
            ans.append(ch)
            visited.insert(ch)
        }
        return String(ans)
    }
}
// @lc code=end


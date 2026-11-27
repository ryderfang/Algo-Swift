/*
 * @lc app=leetcode id=1078 lang=swift
 *
 * [1078] Occurrences After Bigram
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func findOcurrences(_ text: String, _ first: String, _ second: String) -> [String] {
        let words = text.split(separator: " ").map { String($0) }
        let n = words.count
        guard n >= 3 else { return [] }
        var ans = [String]()
        for i in 0..<n-2 {
            if words[i] == first && words[i+1] == second {
                ans.append(words[i+2])
            }
        }
        return ans
    }
}
// @lc code=end

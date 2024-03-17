/*
 * @lc app=leetcode id=2900 lang=swift
 *
 * [2900] Longest Unequal Adjacent Groups Subsequence I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func getLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        let n = groups.count
        var dp0 = [Int]()
        var dp1 = [Int]()
        for i in 0..<n {
            if groups[i] == 0 {
                if dp0.count < dp1.count + 1 {
                    dp0 = dp1 + [i]
                }
            } else {
                if dp1.count < dp0.count + 1 {
                    dp1 = dp0 + [i]
                }
            }
        }
        let dp = dp0.count > dp1.count ? dp0 : dp1
        var ans = [String]()
        for i in dp {
            ans.append(words[i])
        }
        return ans
    }
}
// @lc code=end

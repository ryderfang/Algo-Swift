/*
 * @lc app=leetcode id=1668 lang=swift
 *
 * [1668] Maximum Repeating Substring
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxRepeating1(_ sequence: String, _ word: String) -> Int {
        var cnt = 0
        var tmp = word
        while cnt <= 100 {
            if !sequence.contains(tmp) {
                break
            }
            tmp += word
            cnt += 1
        }
        return cnt
    }

    // DP solution
    func maxRepeating(_ sequence: String, _ word: String) -> Int {
        let n = sequence.count
        let m = word.count
        guard n >= m else { return 0 }
        var dp = [Int](repeating: 0, count: n + 1)
        let sequence = Array(sequence)
        for i in m...n {
            let sub = String(sequence[i-m..<i])
            if sub == word {
                dp[i] = dp[i-m] + 1
            }
        }
        return dp.max() ?? 0
    }
}
// @lc code=end

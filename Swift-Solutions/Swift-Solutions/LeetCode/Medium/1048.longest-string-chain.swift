/*
 * @lc app=leetcode id=1048 lang=swift
 *
 * [1048] Longest String Chain
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func longestStrChain(_ words: [String]) -> Int {
        let n = words.count
        guard n > 1 else { return 1 }
        func _isPredecessor(_ w1: String, _ w2: String) -> Bool {
            for i in 0..<w2.count {
                var tmp = Array(w2)
                tmp.remove(at: i)
                if w1 == String(tmp) {
                    return true
                }
            }
            return false
        }
        let words = words.sorted(by: { $0.count < $1.count })
        let maxLen = words.last?.count ?? 1
        var wordMap: [[String]] = [[String]](repeating: [], count: maxLen + 1)
        for w in words {
            wordMap[w.count].append(w)
        }
        var dp: [[Int]] = [[Int]](repeating: [Int](repeating: 1, count: n), count: maxLen + 1)
        var ans = 1
        for i in 1...maxLen {
            let curWords = wordMap[i]
            guard curWords.count > 0 else {
                continue
            }
            let lastWords = wordMap[i-1]
            guard lastWords.count > 0 else {
                for j in 0..<curWords.count {
                    dp[i][j] = 1
                }
                continue
            }
            for j in 0..<curWords.count {
                for k in 0..<lastWords.count {
                    if _isPredecessor(lastWords[k], curWords[j]) {
                        dp[i][j] = max(dp[i][j], dp[i-1][k] + 1)
                    }
                }
            }
            ans = max(ans, dp[i].max() ?? 1)
        }
        return ans
    }
}
// @lc code=end


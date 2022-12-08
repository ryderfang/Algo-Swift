/*
 * @lc app=leetcode id=139 lang=swift
 *
 * [139] Word Break
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var dic = [String: Int]()
        var wordMaxLength = 0
        for word in wordDict {
            dic[word, default: 0] = 1
            wordMaxLength = max(wordMaxLength, word.count)
        }
        let n = s.count
        var dp = [Int](repeating: 0, count: n + 1)
        dp[0] = 1
        for i in 1...n {
            guard dp[i-1] == 1 else { continue }
            let maxLength = min(n - i + 1, wordMaxLength)
            for j in 0..<maxLength {
                let sub = s[i-1...(i-1+j)]
                if dic[sub, default: 0] > 0 {
                    dp[i+j] = 1
                    if i+j == n {
                        return true
                    }
                }
            }
        }
        return dp[n] == 1
    }
}

fileprivate extension String {
    subscript (r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }
}

// @lc code=end


/*
 * @lc app=leetcode id=583 lang=swift
 *
 * [583] Delete Operation for Two Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minDistance_1(_ word1: String, _ word2: String) -> Int {
        var dp: [String: Int] = [:]
        let sep: String = "$"
        dp[sep] = 0
        func _solve(_ w1: String, _ w2: String) -> Int {
            let concat = w1 + sep + w2
            if let memo = dp[concat] {
                return memo
            }
            
            var ans = Int.max
            if w1.count == 0 {
                ans = min(ans, w2.count)
            } else if w2.count == 0 {
                ans = min(ans, w1.count)
            } else {
                if w1.first == w2.first {
                    var tmp1 = w1
                    tmp1.removeFirst()
                    var tmp2 = w2
                    tmp2.removeFirst()
                    ans = min(ans, _solve(tmp1, tmp2))
                } else {
                    var tmp1 = w1
                    tmp1.removeFirst()
                    ans = min(ans, 1 + _solve(tmp1, w2))
                    var tmp2 = w2
                    tmp2.removeFirst()
                    ans = min(ans, 1 + _solve(w1, tmp2))
                }
            }
            dp[concat] = ans
            return ans
        }
        return _solve(word1, word2)
    }
}
// @lc code=end


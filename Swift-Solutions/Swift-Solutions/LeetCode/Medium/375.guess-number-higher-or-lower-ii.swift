/*
 * @lc app=leetcode id=375 lang=swift
 *
 * [375] Guess Number Higher or Lower II
 */

/*
 * @lc app=leetcode id=375 lang=swift
 *
 * [375] Guess Number Higher or Lower II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func getMoneyAmount(_ n: Int) -> Int {
        var dp: [[Int]] = [[Int]](repeating: [Int](repeating: -1, count: n + 1), count: n + 1)
        for i in 0...n {
            dp[i][i] = 0
        }
        func _solve(_ from: Int, _ to: Int) -> Int {
            let diff = to - from
            guard diff >= 0 else { return 0 }
            if dp[from][to] >= 0 {
                return dp[from][to]
            }
            var ans = Int.max
            for i in from...to {
                ans = min(ans, i + max(_solve(from, i-1), _solve(i+1, to)))
            }
            dp[from][to] = ans
            return ans
        }
        return _solve(1, n)
    }
}
// @lc code=end

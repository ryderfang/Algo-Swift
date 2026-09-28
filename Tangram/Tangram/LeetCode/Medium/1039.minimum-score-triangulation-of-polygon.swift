/*
 * @lc app=leetcode id=1039 lang=swift
 *
 * [1039] Minimum Score Triangulation of Polygon
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minScoreTriangulation(_ values: [Int]) -> Int {
        let cnt = values.count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: cnt), count: cnt)
        // beg-end, k <- [beg+1, end-1]
        func _solve(_ beg: Int, _ end: Int) -> Int {
            let n = end - beg + 1
            guard dp[beg][end] < 0 else {
                return dp[beg][end]
            }
            guard n > 3 else {
                if n == 3 {
                    dp[beg][end] = values[beg] * values[end] * values[beg+1]
                } else {
                    dp[beg][end] = 0
                }
                return dp[beg][end]
            }
            var ans = Int.max
            let fact = values[beg] * values[end]
            for k in beg+1..<end {
                ans = min(ans, _solve(beg, k) + _solve(k, end) + fact * values[k])
            }
            dp[beg][end] = ans
            return ans
        }
        return _solve(0, cnt - 1)
    }
}
// @lc code=end

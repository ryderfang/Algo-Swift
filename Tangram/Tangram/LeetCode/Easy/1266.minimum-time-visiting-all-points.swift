/*
 * @lc app=leetcode id=1266 lang=swift
 *
 * [1266] Minimum Time Visiting All Points
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minTimeToVisitAllPoints(_ points: [[Int]]) -> Int {
        var ans = 0
        let n = points.count
        guard n > 1 else { return 0 }
        for i in 1..<n {
            ans += max(abs(points[i][0] - points[i-1][0]), abs(points[i][1] - points[i-1][1]))
        }
        return ans
    }
}
// @lc code=end


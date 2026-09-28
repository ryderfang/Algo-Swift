/*
 * @lc app=leetcode id=495 lang=swift
 *
 * [495] Teemo Attacking
 */

// @lc code=start
extension Solution {
    func findPoisonedDuration(_ timeSeries: [Int], _ duration: Int) -> Int {
        let n = timeSeries.count
        guard n > 1 else { return duration }
        var ans = 0
        for i in 1..<n {
            ans += min(timeSeries[i] - timeSeries[i-1], duration)
        }
        ans += duration
        return ans
    }
}
// @lc code=end


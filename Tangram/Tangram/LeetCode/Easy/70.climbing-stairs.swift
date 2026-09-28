/*
 * @lc app=leetcode id=70 lang=swift
 *
 * [70] Climbing Stairs
 */

// @lc code=start
extension Solution {
    func climbStairs(_ n: Int) -> Int {
        var ans: [Int] = [1, 2]
        for i in 2..<n {
            ans.append(ans[i-1] + ans[i-2])
        }
        return ans[n-1]
    }
}
// @lc code=end


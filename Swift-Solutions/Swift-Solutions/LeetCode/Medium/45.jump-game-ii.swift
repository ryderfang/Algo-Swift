/*
 * @lc app=leetcode id=45 lang=swift
 *
 * [45] Jump Game II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func jump(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return 0 }
        var dp = [Int](repeating: Int.max, count: n)
        dp[0] = 0
        for i in 0..<n {
            guard nums[i] > 0 else { continue }
            for j in 1...nums[i] {
                guard i + j < n else { break }
                dp[i + j] = min(dp[i + j], dp[i] + 1)
            }
        }
        return dp[n-1]
    }
}
// @lc code=end


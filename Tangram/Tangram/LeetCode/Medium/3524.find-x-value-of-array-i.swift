/*
 * @lc app=leetcode id=3524 lang=swift
 *
 * [3524] Find X Value of Array I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func resultArray(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count
        let total = (n + 1) * n / 2
        guard k > 1 else { return [total] }
        // dp[i][r] -> count for end at [i]
        var dp = [[Int]](repeating: [Int](repeating: 0, count: k), count: n)
        var rem = [Int](repeating: 0, count: n)
        for i in 0..<n {
            rem[i] = nums[i] % k
        }
        dp[0][rem[0]] += 1
        for i in 1..<n {
            dp[i][rem[i]] += 1
            for j in 0..<k {
                let r = (rem[i] * j) % k
                dp[i][r] += dp[i-1][j]
            }
        }
        var res = [Int](repeating: 0, count: k)
        for i in 0..<k {
            for j in 0..<n {
                res[i] += dp[j][i]
            }
        }
        return res
    }
}
// @lc code=end

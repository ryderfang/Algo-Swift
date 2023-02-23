/*
 * @lc app=leetcode id=198 lang=swift
 *
 * [198] House Robber
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func rob1(_ nums: [Int]) -> Int {
        let n = nums.count
        // f[i] -> max money when rob i
        var f = [Int](repeating: 0, count: n)
        f[0] = nums[0]
        for i in 1..<n {
            f[i] = nums[i]
            for j in 0..<i-1 {
                f[i] = max(f[i], f[j] + nums[i])
            }
        }
        return f.max() ?? 0
    }
}
// @lc code=end


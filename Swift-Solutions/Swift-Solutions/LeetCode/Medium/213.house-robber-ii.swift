/*
 * @lc app=leetcode id=213 lang=swift
 *
 * [213] House Robber II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func rob2(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return nums[0] }
        // f[i][0] 表示包含 nums[0] 时，到 i 的最大值
        // f[i][1] 表示不包含 nums[0] 时的最大值
        var f = [[Int]](repeating: [Int](repeating: 0, count: 2), count: n)
        f[0][0] = nums[0]
        f[1][1] = nums[1]
        var (ans0, ans1) = (f[0][0], f[1][1])
        for i in 2..<n {
            f[i][0] = f[0][0] + nums[i]
            f[i][1] = nums[i]
            for j in 1..<i-1 {
                f[i][1] = max(f[i][1], f[j][1] + nums[i])
                f[i][0] = max(f[i][0], f[j][0] + nums[i])
            }
            if i < n - 1 {
                ans0 = max(ans0, f[i][0])
            }
            ans1 = max(ans1, f[i][1])
        }
        // max(f[0..<n-1][0], f[1..<n][1])
        return max(ans0, ans1)
    }

    func rob(_ nums: [Int]) -> Int {
        func _dp(_ start: Int, _ end: Int) -> Int {
            var pre = 0, cur = 0, ans = 0
            for i in start..<end {
                ans = max(pre + nums[i], cur)
                (pre, cur) = (cur, ans)
            }
            return ans
        }
        let n = nums.count
        guard n > 0 else { return 0 }
        guard n > 1 else { return nums[0] }
        return max(_dp(0, n - 1), _dp(1, n))
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=300 lang=swift
 *
 * [300] Longest Increasing Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 最长递增子序列 LIS
    // - O(n^2)
    func lengthOfLIS1(_ nums: [Int]) -> Int {
        let n = nums.count
        var dp = [Int](repeating: 1, count: n)
        for i in 1..<n {
            for j in 0..<i {
                if nums[j] < nums[i] {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
        }
        return dp.max() ?? 1
    }

    // Better solution
    // - O(nlogn)
    func lengthOfLIS(_ nums: [Int]) -> Int {
        let n = nums.count
        var b = [Int]()
        for i in 0..<n {
            let idx = _find(b, nums[i])
            if idx >= 0 && idx < b.count {
                b[idx] = nums[i]
            } else {
                b.append(nums[i])
            }
        }
        func _find(_ ns: [Int], _ target: Int) -> Int {
            let n = ns.count
            guard n > 0 else { return -1 }
            var (l, r) = (0, n)
            while l < r {
                let m = l + (r - l) / 2
                if ns[m] < target {
                    l = m + 1
                } else {
                    r = m
                }
            }
            return r
        }

        return b.count
    }
}
// @lc code=end


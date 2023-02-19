/*
 * @lc app=leetcode id=209 lang=swift
 *
 * [209] Minimum Size Subarray Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // O(nlogn)
    // nums & target positive
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var ans = Int.max
        let n = nums.count
        var sum = [Int](repeating: 0, count: n + 1)
        sum[0] = 0
        for i in 0..<n {
            sum[i+1] = sum[i] + nums[i]
            guard nums[i] != target else {
                return 1
            }
        }
        for i in 0..<n {
            let k = sum[i] + target
            // find min j: sum[j] >= k
            var l = i + 1, r = n
            while l < r {
                let m = l + (r - l) / 2
                if sum[m] < k {
                    l = m + 1
                } else {
                    r = m
                }
            }
            if l <= n && sum[l] >= k {
                ans = min(ans, l - i)
            }
        }
        return ans == Int.max ? 0 : ans
    }
}
// @lc code=end


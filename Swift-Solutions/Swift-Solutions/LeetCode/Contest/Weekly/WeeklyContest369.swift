//
//  WeeklyContest369.swift
//  Titan
//
//  Created by ryfang on 2023/10/29.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findKOr(_ nums: [Int], _ k: Int) -> Int {
        var ans = 0
        for i in 0..<32 {
            let bit = 1 << i
            var count = 0
            for x in nums {
                if (bit & x) == bit {
                    count += 1
                }
            }
            if count >= k {
                ans += bit
            }
        }
        return ans
    }

    func minSum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var (cnt1, sum1) = (0, 0)
        for x in nums1 {
            if x == 0 {
                cnt1 += 1
            }
            sum1 += x
        }
        var (cnt2, sum2) = (0, 0)
        for x in nums2 {
            if x == 0 {
                cnt2 += 1
            }
            sum2 += x
        }
        var ans = -1
        let k1 = sum1 + cnt1
        let k2 = sum2 + cnt2
        if cnt1 > 0 && cnt2 > 0 {
            ans = max(k1, k2)
        } else if cnt1 == 0 && cnt2 > 0 {
            ans = (k1 >= k2 ? k1: -1)
        } else if cnt2 == 0 && cnt1 > 0 {
            ans = (k1 <= k2 ? k2 : -1)
        } else if cnt1 == 0 && cnt2 == 0 {
            ans = (k1 == k2 ? k1 : -1)
        }
        return ans
    }

    func minIncrementOperations(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var dp = [Int](repeating: 0, count: n)
        dp[2] = max(0, k - max(nums[0], nums[1], nums[2]))
        var i = 3
        while i < n {
            dp[i] = min(
                dp[i-1] + max(0, k - nums[i]),
                dp[i-2] + max(0, k - nums[i-1]),
                dp[i-3] + max(0, k - nums[i-2])
            )
            i += 1
        }
        return dp[n-1]
    }
}
// @lc code=end

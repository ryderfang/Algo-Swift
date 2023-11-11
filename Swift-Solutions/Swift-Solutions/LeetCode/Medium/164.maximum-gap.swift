/*
 * @lc app=leetcode id=164 lang=swift
 *
 * [164] Maximum Gap
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maximumGap1(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return 0 }
        let nums = nums.sorted()
        var ans = 0
        for i in 1..<n {
            ans = max(ans, nums[i] - nums[i-1])
        }
        return ans
    }

    // Better solution: 分桶思想
    func maximumGap(_ nums: [Int]) -> Int {
        let n = nums.count
        let mi = nums.min()!
        let ma = nums.max()!
        guard mi != ma else { return 0 }

        let bucketSize = Int(ceil(Double(ma-mi) / Double(n-1)))
        var minMaxBucket = Array(repeating: (min: Int.max, max: Int.min), count: n )
        for num in nums {
            let idx = (num - mi) / bucketSize
            minMaxBucket[idx].min = min(minMaxBucket[idx].min, num)
            minMaxBucket[idx].max = max(minMaxBucket[idx].max, num)
        }

        var maxGap: Int = bucketSize
        var prev = minMaxBucket[0].max
        for i in 1..<n where minMaxBucket[i].min != Int.max {
            maxGap = max(maxGap, minMaxBucket[i].min - prev)
            prev = minMaxBucket[i].max
        }
        return maxGap
    }
}
// @lc code=end


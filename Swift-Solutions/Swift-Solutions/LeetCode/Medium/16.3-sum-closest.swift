/*
 * @lc app=leetcode id=16 lang=swift
 *
 * [16] 3Sum Closest
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let nums = nums.sorted()
        let n = nums.count
        guard n > 3 else { return nums.reduce(0, +) }
        var diff = Int.max
        var ans = Int.max
        for i in 0..<n-2 {
            if i > 0 && nums[i] == nums[i-1] { continue }
            var l = i + 1, r = n - 1
            let x = target - nums[i]
            while l < r {
                let sum = nums[l] + nums[r]
                if sum == x {
                    return target
                } else {
                    sum > x ? r -= 1 : (l += 1)
                    if abs(sum - x) < diff {
                        diff = abs(sum - x)
                        ans = sum + nums[i]
                    }
                }
            }
        }
        return ans
    }
}
// @lc code=end


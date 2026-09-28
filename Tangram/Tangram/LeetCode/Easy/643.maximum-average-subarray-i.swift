/*
 * @lc app=leetcode id=643 lang=swift
 *
 * [643] Maximum Average Subarray I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var ans = nums[0..<k].reduce(0, +)
        let n = nums.count
        if n > k {
            var tmp = ans
            for i in 1...n-k {
                tmp = tmp - nums[i-1] + nums[i+k-1]
                ans = max(ans, tmp)
            }
        }
        return (Double(ans) / Double(k)).truncate5()
    }
}

fileprivate extension Double {
    func truncate5() -> Double {
        return Double(Int(self * 100000.0)) / 100000.0
    }
}

// @lc code=end


/*
 * @lc app=leetcode id=494 lang=swift
 *
 * [494] Target Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    /*
     * (A - B) = target
     * (A + B) = sum
     * B = (sum - target) / 2
     * -> 0-1 knapsack
     */
    func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        let sum = nums.reduce(0, +)
        guard target >= -sum && target <= sum else { return 0 }
        guard (sum - target) % 2 == 0 else { return 0 }
        let T = (sum - target) / 2
        var dp = [Int](repeating: 0, count: T + 1)
        dp[0] = 1
        for num in nums {
            for cur in stride(from: T, through: num, by: -1) {
                dp[cur] += dp[cur - num]
            }
        }
        return dp[T]
    }
    
    // n <- [1, 20]
    // nums[i] <- [0, 1000]
    func findTargetSumWays1(_ nums: [Int], _ target: Int) -> Int {
        var dp = [Int: Int]()
        let n = nums.count
        for i in 0..<n {
            if i == 0 {
                dp[nums[i], default: 0] += 1
                dp[-nums[i], default: 0] += 1
            } else {
                var tmp = [Int: Int]()
                for (k, v) in dp {
                    tmp[k+nums[i], default: 0] += v
                    tmp[k-nums[i], default: 0] += v
                }
                dp = tmp
            }
        }
        return dp[target, default: 0]
    }
}
// @lc code=end


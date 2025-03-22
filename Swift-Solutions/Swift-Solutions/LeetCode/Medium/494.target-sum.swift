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
    // DP
    func findTargetSumWays1(_ nums: [Int], _ target: Int) -> Int {
        let sum = nums.reduce(0, +)
        guard target >= -sum && target <= sum else { return 0 }

        let n = nums.count
        var memo = Array(repeating: Array(repeating: 0, count: sum * 2 + 1), count: n)
        memo[0][sum + nums[0]] = 1
        memo[0][sum - nums[0]] += 1 // nums[0] could be 0

        for i in 1..<n {
            let num = nums[i]
            for j in 0...2*sum {
                if memo[i - 1][j] > 0 { // if there's valid sum of j up to index i - 1
                    memo[i][j + num] += memo[i - 1][j]
                    memo[i][j - num] += memo[i - 1][j]
                }
            }
        }

        return memo[n - 1][sum + target]
    }
    
    // Better solution
    /*
     * A: elements use "add"
     * B: elements use "sub"
     * (A - B) = target
     * (A + B) = sum
     * B = (sum - target) / 2
     * -> 0-1 knapsack
     */
    func findTargetSumWays2(_ nums: [Int], _ target: Int) -> Int {
        let sum = nums.reduce(0, +)
        guard target >= -sum && target <= sum else { return 0 }
        guard (sum - target) % 2 == 0 else { return 0 }
        let T = (sum - target) / 2
        // dp[cur] -> 到 nums[i] 时和为 cur 的个数
        // dp[i][cur] = dp[i-1][cur] + dp[i-1][cur-nums_i]
        // 一维化后即，dp[cur] += dp[cur-nums_i]
        var dp = [Int](repeating: 0, count: T + 1)
        dp[0] = 1
        for num in nums {
            for cur in stride(from: T, through: num, by: -1) {
                dp[cur] += dp[cur - num]
            }
        }
        return dp[T]
    }
    
    // 也可以将 A 的个数作为 T
    func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        let sum = nums.reduce(0, +)
        guard target >= -sum && target <= sum else { return 0 }
        guard (sum + target) % 2 == 0 else { return 0 }
        let T = (sum + target) / 2
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
    func findTargetSumWays3(_ nums: [Int], _ target: Int) -> Int {
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


/*
 * @lc app=leetcode id=518 lang=swift
 *
 * [518] Coin Change II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        let n = coins.count
        let coins = coins.sorted()
        var dp = [[Int]](repeating: [Int](repeating: Int.min, count: n), count: 5001)
        func _solve(_ remain: Int, _ start: Int) -> Int {
            guard remain > 0 else { return 1 }
            guard start < n else { return 0 }
            guard dp[remain][start] == Int.min else { return dp[remain][start] }
            var ans = 0
            var tmp = remain
            while tmp >= 0 {
                ans += _solve(tmp, start + 1)
                tmp -= coins[start]
            }
            dp[remain][start] = ans
            return ans
        }
        let ans = _solve(amount, 0)
        return ans
    }
}
// @lc code=end


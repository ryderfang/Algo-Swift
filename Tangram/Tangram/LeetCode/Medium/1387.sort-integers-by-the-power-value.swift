/*
 * @lc app=leetcode id=1387 lang=swift
 *
 * [1387] Sort Integers by The Power Value
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 3x+1 问题
    func getKth(_ lo: Int, _ hi: Int, _ k: Int) -> Int {
        let maxSize = 500000
        var dp = [Int](repeating: 0, count: maxSize)
        func _power(_ x: Int) -> Int {
            if x == 1 { return 0 }
            if dp[x] > 0 { return dp[x] }
            if x & 1 == 0 {
                dp[x] = _power(x >> 1) + 1
            } else {
                dp[x] = _power(3 * x + 1) + 1
            }
            return dp[x]
        }
        let sorted: [(Int, Int)] = (lo...hi).map { ($0, _power($0)) }.sorted(by: {
            $0.1 < $1.1 || ($0.1 == $1.1 && $0.0 < $1.0)
        })
        return sorted[k-1].0
    }
}
// @lc code=end

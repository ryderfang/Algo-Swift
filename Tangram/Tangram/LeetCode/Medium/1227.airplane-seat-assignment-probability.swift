/*
 * @lc app=leetcode id=1227 lang=swift
 *
 * [1227] Airplane Seat Assignment Probability
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 0 - 1/1
    // 01,10 - 1/2
    // 012,102,120,210 - 2/4
    // 0123,1023,1203,1230,1320,2103,2130,3120 - 4/8
    func nthPersonGetsNthSeat2(_ n: Int) -> Double {
        n == 1 ? 1.00000 : 0.50000
    }

    // dp[n] = 1/n + (n-2)/n * dp[n-1]
    func nthPersonGetsNthSeat(_ n: Int) -> Double {
        guard n > 1 else { return 1.0 }
        var ret = 1.0
        for i in 2...n {
            ret = Double(1) / Double(i) + ret * Double(i-2) / Double(i)
        }
        return ret
    }
}
// @lc code=end

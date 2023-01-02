/*
 * @lc app=leetcode id=860 lang=swift
 *
 * [860] Lemonade Change
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func lemonadeChange(_ bills: [Int]) -> Bool {
        var count5 = 0, count10 = 0
        for b in bills {
            if b == 5 {
                count5 += 1
            } else if b == 10 {
                guard count5 > 0 else { return false }
                count5 -= 1
                count10 += 1
            } else {
                if count10 > 0 && count5 > 0 {
                    count5 -= 1
                    count10 -= 1
                } else if count10 == 0 && count5 >= 3 {
                    count5 -= 3
                } else {
                    return false
                }
            }
        }
        return true
    }
}
// @lc code=end


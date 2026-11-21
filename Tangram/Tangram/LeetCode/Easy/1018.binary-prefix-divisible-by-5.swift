/*
 * @lc app=leetcode id=1018 lang=swift
 *
 * [1018] Binary Prefix Divisible By 5
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func prefixesDivBy5(_ nums: [Int]) -> [Bool] {
        var ans = [Bool]()
        var tmp = 0
        for x in nums {
            tmp = ((2 * tmp % 100) + x) % 100
            ans.append(tmp % 5 == 0 ? true : false)
        }
        return ans
    }
}
// @lc code=end

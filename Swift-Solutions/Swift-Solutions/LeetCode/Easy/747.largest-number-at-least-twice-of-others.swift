/*
 * @lc app=leetcode id=747 lang=swift
 *
 * [747] Largest Number At Least Twice of Others
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func dominantIndex(_ nums: [Int]) -> Int {
        var largest = Int.min, second = Int.min
        var ans = -1
        for (i, x) in nums.enumerated() {
            if x > largest {
                second = largest
                largest = x
                ans = i
            } else if x > second {
                second = x
            }
        }
        return largest >= 2 * second ? ans : -1
    }
}
// @lc code=end


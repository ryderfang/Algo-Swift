/*
 * @lc app=leetcode id=1051 lang=swift
 *
 * [1051] Height Checker
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func heightChecker(_ heights: [Int]) -> Int {
        // one line 
        zip(heights, heights.sorted()).filter({ $0 != $1 }).count
        // let sorted = heights.sorted()
        // var ans = 0
        // for i in 0..<heights.count {
        //     if heights[i] != sorted[i] {
        //         ans += 1
        //     }
        // }
        // return ans
    }
}
// @lc code=end

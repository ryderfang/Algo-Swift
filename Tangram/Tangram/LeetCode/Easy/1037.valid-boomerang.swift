/*
 * @lc app=leetcode id=1037 lang=swift
 *
 * [1037] Valid Boomerang
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isBoomerang(_ points: [[Int]]) -> Bool {
        let vec1 = (points[1][0] - points[0][0], points[1][1] - points[0][1])
        let vec2 = (points[2][0] - points[0][0], points[2][1] - points[0][1])
        return (vec1.0 * vec2.1 - vec1.1 * vec2.0) != 0
    }
}
// @lc code=end

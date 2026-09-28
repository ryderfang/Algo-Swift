/*
 * @lc app=leetcode id=973 lang=swift
 *
 * [973] K Closest Points to Origin
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func kClosest(_ points: [[Int]], _ k: Int) -> [[Int]] {
        Array(points.sorted { (p1, p2) in
            p1[0] * p1[0] + p1[1] * p1[1] <= p2[0] * p2[0] + p2[1] * p2[1]
        }[0..<k])
    }
}
// @lc code=end

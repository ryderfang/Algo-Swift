/*
 * @lc app=leetcode id=223 lang=swift
 *
 * [223] Rectangle Area
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func computeArea(_ ax1: Int, _ ay1: Int, _ ax2: Int, _ ay2: Int, _ bx1: Int, _ by1: Int, _ bx2: Int, _ by2: Int) -> Int {
        let width = (ax1..<ax2).clamped(to: bx1..<bx2).count
        let height = (ay1..<ay2).clamped(to: by1..<by2).count
        let crossArea = width * height
        let area1 = (ax2 - ax1) * (ay2 - ay1)
        let area2 = (bx2 - bx1) * (by2 - by1)
        return area1 + area2 - crossArea
    }
}
// @lc code=end


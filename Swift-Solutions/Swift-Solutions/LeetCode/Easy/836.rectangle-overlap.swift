/*
 * @lc app=leetcode id=836 lang=swift
 *
 * [836] Rectangle Overlap
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func _isRectangleOverlap(_ rec1: [Int], _ rec2: [Int]) -> Bool {
        let center1 = ((rec1[0] + rec1[2]) / 2, (rec1[1] + rec1[3]) / 2)
        let center2 = ((rec2[0] + rec2[2]) / 2, (rec2[1] + rec2[3]) / 2)
        let width = (rec1[2] - rec1[0] + rec2[2] - rec2[0]) / 2
        let height = (rec1[3] - rec1[1] + rec2[3] - rec2[1]) / 2

        if abs(center2.0 - center1.0) >= width || abs(center2.1 - center1.1) >= height {
            return false
        }
        return true
    }

    func isRectangleOverlap(_ rec1: [Int], _ rec2: [Int]) -> Bool {
        return (rec1[0]..<rec1[2]).overlaps(rec2[0]..<rec2[2]) &&
               (rec1[1]..<rec1[3]).overlaps(rec2[1]..<rec2[3])
    }
}
// @lc code=end


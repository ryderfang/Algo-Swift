/*
 * @lc app=leetcode id=1232 lang=swift
 *
 * [1232] Check If It Is a Straight Line
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: 多点共线，斜率相同
    func checkStraightLine(_ coordinates: [[Int]]) -> Bool {
        let n = coordinates.count
        guard n > 2 else { return true }
        var gradient = Set<Float>()
        let (x0, y0) = (coordinates[0][0], coordinates[0][1])
        for i in 1..<n {
            gradient.insert(coordinates[i][0] == x0 ? .infinity :
            Float(coordinates[i][1] - y0) / Float(coordinates[i][0] - x0))
        }
        return gradient.count == 1
    }

    func checkStraightLine1(_ coordinates: [[Int]]) -> Bool {
        let n = coordinates.count
        guard n >= 3 else { return true }
        // (p3, p1) X (p3, p2)
        func _isInOneLine(p1: [Int], p2: [Int], p3: [Int]) -> Bool {
            (p1[0] - p3[0]) * (p2[1] - p3[1]) - (p2[0] - p3[0]) * (p1[1] - p3[1]) == 0
        }
        var ans = true
        for i in 2..<n {
            if !_isInOneLine(p1: coordinates[i-2], p2: coordinates[i-1], p3: coordinates[i]) {
                ans = false
                break
            }
        }
        return ans
    }
}
// @lc code=end

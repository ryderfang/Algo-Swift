/*
 * @lc app=leetcode id=593 lang=swift
 *
 * [593] Valid Square
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Another solution: sort & calc
    func validSquare(_ p1: [Int], _ p2: [Int], _ p3: [Int], _ p4: [Int]) -> Bool {
        func _calDistance(_ p1: [Int], _ p2: [Int]) -> Int {
            (p2[1] - p1[1]) * (p2[1] - p1[1]) + (p2[0] - p1[0]) * (p2[0] - p1[0])
        }
        var points = [p1, p2, p3, p4]
        points.sort { $0[0] < $1[0]  || $0[0] == $1[0] && $0[1] < $1[1] }
        if _calDistance(points[0], points[3]) != _calDistance(points[1], points[2]) {
            return false
        }
        let distance1 = _calDistance(points[0], points[1])
        let distance2 = _calDistance(points[0], points[2])
        let distance3 = _calDistance(points[3], points[2])
        let distance4 = _calDistance(points[3], points[1])

         return (distance1 != 0 &&
                 distance1 == distance2 &&
                 distance2 == distance3 &&
                 distance3 == distance4)

    }
    func validSquare1(_ p1: [Int], _ p2: [Int], _ p3: [Int], _ p4: [Int]) -> Bool {
        func _perpendicular(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
            (u1[0] - u2[0]) * (v1[0] - v2[0]) + (u1[1] - u2[1]) * (v1[1] - v2[1]) == 0
        }
        func _lengthEqual(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
            ((u1[0] - u2[0]) * (u1[0] - u2[0]) + (u1[1] - u2[1]) * (u1[1] - u2[1])) ==
            ((v1[0] - v2[0]) * (v1[0] - v2[0]) + (v1[1] - v2[1]) * (v1[1] - v2[1]))
        }
        func _forthPointOfRect(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> [Int] {
            [p1[0] + p2[0] - p0[0], p1[1] + p2[1] - p0[1]]
        }

        // p1 == p2 == p3 == p4
        guard p1 != p2 else { return false }

        if _perpendicular(p1, p2, p1, p3) && _lengthEqual(p1, p2, p1, p3) {
            if _forthPointOfRect(p1, p2, p3) == p4 {
                return true
            }
        }
        if _perpendicular(p1, p2, p1, p4) && _lengthEqual(p1, p2, p1, p4) {
            if _forthPointOfRect(p1, p2, p4) == p3 {
                return true
            }
        }
        if _perpendicular(p1, p3, p1, p4) && _lengthEqual(p1, p3, p1, p4) {
            if _forthPointOfRect(p1, p3, p4) == p2 {
                return true
            }
        }
        return false
    }


}
// @lc code=end


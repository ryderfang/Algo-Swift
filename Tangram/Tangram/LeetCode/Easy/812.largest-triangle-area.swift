/*
 * @lc app=leetcode id=812 lang=swift
 *
 * [812] Largest Triangle Area
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func largestTriangleArea(_ points: [[Int]]) -> Double {
        func _area(_ p1: [Int], _ p2: [Int], _ p3: [Int]) -> Double {
            let (x1, y1) = (Double(p1[0]), Double(p1[1]))
            let (x2, y2) = (Double(p2[0]), Double(p2[1]))
            let (x3, y3) = (Double(p3[0]), Double(p3[1]))
            return fabs((x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)) / 2
        }
        let n = points.count
        var ans: Double = 0
        for i in 0..<n {
            for j in 0..<n {
                for k in 0..<n {
                    guard i != j && j != k else { continue }
                    ans = max(ans, _area(points[i], points[j], points[k]))
                }
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=963 lang=swift
 *
 * [963] Minimum Area Rectangle II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Another solution: check and find forth point
    func minAreaFreeRect(_ points: [[Int]]) -> Double {
        struct _Point: Hashable {
            var x: Int
            var y: Int
            init(_ p: [Int]) {
                x = p[0]
                y = p[1]
            }
        }

        func _perpendicular(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
            (u1[0] - u2[0]) * (v1[0] - v2[0]) + (u1[1] - u2[1]) * (v1[1] - v2[1]) == 0
        }
        func _xmult(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Int {
            (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])
        }
        let n = points.count
        guard n >= 4 else { return 0.0 }
        let ps = Set<_Point>(points.map { _Point($0) })
        var ans = Int.max
        for i in 0..<n {
            for j in 0..<n {
                guard j != i else { continue }
                for k in 0..<n{
                    guard k != i && k != j else { continue }
                    let (p0, p1, p2) = (points[i], points[j], points[k])
                    if _perpendicular(p0, p1, p0, p2) {
                        let tmp = abs(_xmult(p0, p1, p2))
                        if tmp < ans {
                            // p0 -> p1 垂直 p0 -> p2
                            // p1 -> p3 == p0 -> p2
                            // [p1.x - p3.x, p1.y - p3.y] = [p2.x - p0.x, p2.y - p0.y]
                            let forth = [p1[0] + p2[0] - p0[0], p1[1] + p2[1] - p0[1]]
                            if ps.contains(_Point(forth)) {
                                ans = tmp
                            }
                        }
                    }
                }
            }
        }
        return ans == Int.max ? 0.0 : Double(ans)
    }

    func minAreaFreeRect1(_ points: [[Int]]) -> Double {
        // 直线平行
        func _parallel(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
            (u1[0] - u2[0]) * (v1[1] - v2[1]) == (v1[0] - v2[0]) * (u1[1] - u2[1])
        }

        // 直线垂直
        func _perpendicular(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
            (u1[0] - u2[0]) * (v1[0] - v2[0]) + (u1[1] - u2[1]) * (v1[1] - v2[1]) == 0
        }

        func _xmult(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Int {
            (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])
        }

        func _rectArea(_ p0: [Int], _ p1: [Int], _ p2: [Int], _ p3: [Int]) -> Int {
            if _perpendicular(p0, p1, p0, p2) {
                if _parallel(p0, p1, p2, p3) && _parallel(p0, p2, p1, p3) {
                    return abs(_xmult(p0, p1, p2))
                }
            }
            if _perpendicular(p0, p1, p0, p3) {
                if _parallel(p0, p1, p2, p3) && _parallel(p0, p3, p1, p2) {
                    return abs(_xmult(p0, p1, p3))
                }
            }
            if _perpendicular(p0, p2, p0, p3) {
                if _parallel(p0, p2, p1, p3) && _parallel(p0, p3, p1, p2) {
                    return abs(_xmult(p0, p2, p3))
                }
            }
            return Int.max
        }

        let n = points.count
        guard n >= 4 else { return 0.0 }
        var ans = Int.max
        for i in 0..<n-3 {
            for j in i+1..<n-2 {
                for k in j+1..<n-1 {
                    for l in k+1..<n {
                        ans = min(ans, _rectArea(points[i], points[j], points[k], points[l]))
                    }
                }
            }
        }
        return ans == Int.max ? 0.0 : Double(ans)
    }
}

// @lc code=end

/*
 * @lc app=leetcode id=1610 lang=swift
 *
 * [1610] Maximum Number of Visible Points
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func visiblePoints(_ points: [[Int]], _ angle: Int, _ location: [Int]) -> Int {
        let eps: Double = 1e-8
        func _theta(_ p1: Point, _ p0: Point) -> Double {
            if fabs(p1.x - p0.x) < eps && fabs(p1.y - p0.y) < eps {
                return -Double.infinity
            }
            // [-pi, pi] -> [0, 2*pi]
            var ret = atan2(p1.y - p0.y, p1.x - p0.x)
            if ret < 0 {
                ret += 2 * Double.pi
            }
            return ret
        }

        let p0 = Point(location)
        var ps = points.map {
            var p = Point($0)
            p.angle = _theta(p, p0)
            return p
        }.sorted { $0.angle < $1.angle }
         .filter({ $0.angle >= 0 })
        let angle = Double(angle) * Double.pi / 180
        // count of points at location
        let cnt0 = points.count - ps.count
        let n = ps.count
        guard n > 1 else { return n + cnt0 }
        // minimum is 1 point
        var ans = 1
        var (i, j) = (0, 1)
        // 视野可能跨过 (0, 2*pi) 分界线
        ps = ps + ps.map {
            var p = Point($0.x, $0.y)
            p.angle = $0.angle + 2 * Double.pi
            return p
        }
        while i < n {
            if j < 2 * n && ps[j].angle - ps[i].angle <= angle {
                ans = max(ans, j - i + 1)
                j += 1
            } else {
                i += 1
            }
        }
        return ans + cnt0
    }
}

fileprivate extension Solution {
    struct Point: Hashable {
        var x: Double
        var y: Double
        var angle: Double = 0
        init(_ di: Double, _ dj: Double ) { (x, y) = (di, dj) }
        init(_ p: [Int]) { (x, y) = (Double(p[0]), Double(p[1])) }
    }
}
// @lc code=end

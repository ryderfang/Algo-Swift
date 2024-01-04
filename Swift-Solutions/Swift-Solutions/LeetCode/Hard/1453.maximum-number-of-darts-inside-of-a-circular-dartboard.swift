/*
 * @lc app=leetcode id=1453 lang=swift
 *
 * [1453] Maximum Number of Darts Inside of a Circular Dartboard
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numPoints(_ darts: [[Int]], _ r: Int) -> Int {
        /*
         (x1-x0)^2 + (y1-y0)^2 = r^2 (1)
         (x2-x0)^2 + (y2-y0)^2 = r^2 (2)
        (1)-(2):
         x1^2+y1^2-2x1x0-2y1y0 = x2^2+y2^2-2*x2x0-2y2y0
         -> x0 = (x2^2-x1^2+y2^2-y1^2)/2/(x2-x1) - ((y2-y1)/(x2-x1))*y0
         -> x0 = c1 - c2y0           (3)
        (3)->(1)
         (x1-c1+c2y0)^2 + (y1-y0)^2 = r^2
         (c2^2+1)y0^2 + (2c2(x1-c1)-2y1)y0 + (x1-c1)^2+y1^2-r^2 = 0
         Ay0^2 + By0 + C = 0
         y0 = (-B+sqrt(B^2-4AC))/2A / (-B-sqrt(B^2-4AC))/2A
       */
        // 已知圆上两点和半径，求圆心（有两个解）
        func _centerOfCircle(_ p1: Point, _ p2: Point, _ r: Double) -> [Point] {
            let c1 = (p2.x * p2.x - p1.x * p1.x + p2.y * p2.y - p1.y * p1.y) / (2 * (p2.x - p1.x))
            let c2 = (p2.y - p1.y) / (p2.x - p1.x)
            let a = c2 * c2 + 1
            let b = 2 * c2 * (p1.x - c1) - 2 * p1.y
            let c = (p1.x - c1) * (p1.x - c1) + p1.y * p1.y - r * r
            var y0 = (-b + sqrt(b * b - 4 * a * c)) / (2 * a)
            var x0 = c1 - c2 * y0
            var ans = [Point(x0, y0)]
            y0 = (-b - sqrt(b * b - 4 * a * c)) / (2 * a)
            x0 = c1 - c2 * y0
            ans.append(Point(x0, y0))
            return ans
        }

        func _insideCircle(_ p1: Point, _ p0: Point, _ r: Double) -> Bool {
            (p1.x - p0.x) * (p1.x - p0.x) + (p1.y - p0.y) * (p1.y - p0.y) <= r * r
        }

        let n = darts.count
        let ps = darts.map { Point($0) }
        guard n > 2 else { return n }
        var centers = Set<Point>()
        let r = Double(r)
        // minimum is one circle
        var ans = 1
        for i in 0..<n-1 {
            for j in i+1..<n {
                _centerOfCircle(ps[i], ps[j], r).forEach { centers.insert($0) }
            }
        }
        for c in centers {
            var tmp = 0
            for j in 0..<n {
                if _insideCircle(ps[j], c, r) {
                    tmp += 1
                }
            }
            ans = max(ans, tmp)
        return ans
        }
    }
}

fileprivate extension Solution {
    struct Point: Hashable {
        var x: Double
        var y: Double
        init(_ di: Double, _ dj: Double ) { (x, y) = (di, dj) }
        init(_ p: [Int]) { (x, y) = (Double(p[0]), Double(p[1])) }
    }
}
// @lc code=end

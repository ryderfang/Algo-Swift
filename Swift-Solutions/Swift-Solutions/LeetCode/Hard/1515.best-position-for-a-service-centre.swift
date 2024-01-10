/*
 * @lc app=leetcode id=1515 lang=swift
 *
 * [1515] Best Position for a Service Centre
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

// 平面费马点问题 (Fermat Point)
extension Solution {
    fileprivate func _dist(_ p0: Point, _ p1: Point) -> Double {
        sqrt((p0.x - p1.x) * (p0.x - p1.x) + (p0.y - p1.y) * (p0.y - p1.y))
    }
    fileprivate func _calcDistSum(_ p0: Point, _ ps: [Point]) -> Double {
        var ret = 0.0
        for p in ps {
            ret += _dist(p0, p)
        }
        return ret
    }

    // 模拟退火
    func getMinDistSum2(_ positions: [[Int]], _ eps: Double = 1e-6) -> Double {
        let ps = positions.map { Point($0) }
        let n = ps.count
        guard n > 2 else { return _dist(ps[0], ps[n-1]) }
        var p0 = Point(0.0, 0.0)
        for p in ps {
            p0.x += p.x
            p0.y += p.y
        }
        // 初始点：重心
        p0.x /= Double(n)
        p0.y /= Double(n)
        // 上下左右
        let d: [(Double, Double)] = [(0, -1), (0, 1), (-1, 0), (1, 0)]
        // 初始状态，降温系数
        let T0: Double = 100, delta = 0.98
        var t = T0
        var ans = _calcDistSum(p0, ps)
        while t > eps {
            var hasBetter = true
            while hasBetter {
                hasBetter = false
                for i in 0..<4 {
                    let p1 = Point(p0.x + d[i].0 * t, p0.y + d[i].1 * t)
                    let tmp = _calcDistSum(p1, ps)
                    if tmp < ans {
                        ans = tmp
                        p0 = p1
                        hasBetter = true
                    }
                }
            }
            t *= delta
        }
        return ans
    }

    // 牛顿迭代法 (误差更大，eps 要小一点)
    func getMinDistSum(_ positions: [[Int]], _ eps: Double = 1e-7) -> Double {
        let ps = positions.map { Point($0) }
        let n = ps.count
        guard n > 2 else { return _dist(ps[0], ps[n-1]) }
        var p0 = Point(0.0, 0.0)
        for p in ps {
            p0.x += p.x
            p0.y += p.y
        }
        // 初始点：重心
        p0.x /= Double(n)
        p0.y /= Double(n)
        var ans = _calcDistSum(p0, ps)
        while true {
            var (x1, x2) = (0.0, 0.0)
            var (y1, y2) = (0.0, 0.0)
            for p in ps {
                let g = _dist(p0, p)
                guard g > 0 else { continue }
                x1 = x1 + p.x / g
                x2 = x2 + 1.0 / g
                y1 = y1 + p.y / g
                y2 = y2 + 1.0 / g
            }
            guard x2 > 0 && y2 > 0 else { break }
            p0 = Point(x1 / x2, y1 / y2)
            let tmp = _calcDistSum(p0, ps)
            if fabs(tmp - ans) < eps {
                ans = tmp
                break
            }
            ans = tmp
        }
        return ans
    }
}

fileprivate extension Solution {
    typealias PointI = _Point<Int>
    typealias Point = _Point<Double>
    struct _Point<T: Hashable>: Hashable {
        var x: T
        var y: T
        init(_ di: T, _ dj: T) { (x, y) = (di, dj) }
        init(_ p: [T]) { (x, y) = (p[0], p[1]) }
    }
}

extension Solution._Point where T == Double {
    init(_ p: [Int]) { (x, y) = (Double(p[0]), Double(p[1])) }
}
// @lc code=end
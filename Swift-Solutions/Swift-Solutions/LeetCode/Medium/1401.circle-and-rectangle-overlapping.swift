/*
 * @lc app=leetcode id=1401 lang=swift
 *
 * [1401] Circle and Rectangle Overlapping
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // axis-aligned - 矩形与坐标轴平行
    func checkOverlap(_ radius: Int, _ xCenter: Int, _ yCenter: Int, _ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) -> Bool {
        let rectW = Double(x2 - x1)
        let rectH = Double(y2 - y1)
        let rectX = Double(x1 + x2) / 2
        let rectY = Double(y1 + y2) / 2
        
        // distance between circle center and rectangle center
        let dx = fabs(Double(xCenter) - rectX)
        let dy = fabs(Double(yCenter) - rectY)
        if dx > Double(radius) + rectW / 2 { return false }
        if dy > Double(radius) + rectH / 2 { return false }
        if dx <= rectW / 2 { return true }
        if dy <= rectH / 2 { return true }
        return (dx - rectW / 2) * (dx - rectW / 2) + (dy - rectH / 2) * (dy - rectH / 2) <= Double(radius) * Double(radius)
    }

    // Common solution
    func checkOverlap1(_ radius: Int, _ xCenter: Int, _ yCenter: Int, _ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) -> Bool {
        let c = Point(xCenter, yCenter)
        let dist = Double(radius)
        let (p0, p1, p2, p3) = (Point(x1, y2), Point(x1, y1), Point(x2, y1), Point(x2, y2))
        let (line0, line1, line2, line3) = (Line(p0, p1), Line(p1, p2), Line(p2, p3), Line(p3, p0))
        if Self.distancePointToSegment(c, line0) > dist && Self.distancePointToSegment(c, line1) > dist &&
            Self.distancePointToSegment(c, line2) > dist && Self.distancePointToSegment(c, line3) > dist {
            // circle inside rectangle
            if x1 < xCenter && xCenter < x2 && y1 < yCenter && yCenter < y2 {
                return true
            }
            return false
        }
        return true
    }
}

fileprivate extension Solution {
    static var eps: Double = 1e-8

    // make it internal hashable
    struct Point: Hashable {
        var x: Double
        var y: Double
        init(_ i: Int = 0, _ j: Int = 0) { (x, y) = (Double(i), Double(j)) }
        init(_ p: [Double]) { (x, y) = (p[0], p[1]) }
    }

    struct Line {
        var a: Point
        var b: Point
        init(_ p0: Point, _ p1: Point) { (a, b) = (p0, p1) }
    }

    static func xmult(_ p1: Point, _ p2: Point, _ p0: Point) -> Double {
        (p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y)
    }

    static func intersection(_ u: Line, _ v: Line) -> Point {
        var ret = u.a
        let t = ((u.a.x - v.a.x) * (v.a.y - v.b.y) - (u.a.y - v.a.y) * (v.a.x - v.b.x)) /
        ((u.a.x - u.b.x) * (v.a.y - v.b.y) - (u.a.y - u.b.y) * (v.a.x - v.b.x))
        ret.x += (u.b.x - u.a.x) * t
        ret.y += (u.b.y - u.a.y) * t
        return ret
    }

    static func distance(_ p1: Point, _ p2: Point) -> Double {
        sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y))
    }

    static func distancePointToSegment(_ p: Point, _ l: Line) -> Double {
        var t = p
        t.x += l.a.y - l.b.y
        t.y += l.b.x - l.a.x
        if xmult(l.a, t, p) * xmult(l.b, t, p) > eps {
            return min(distance(p, l.a), distance(p, l.b))
        }
        return fabs(xmult(p, l.a, l.b)) / distance(l.a, l.b)
    }
}

// @lc code=end


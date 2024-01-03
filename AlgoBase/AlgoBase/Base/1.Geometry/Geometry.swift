//
//  Geometry.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/23.
//

import Foundation

// 计算几何 (Double)
class Geometry {
    static var eps: Double = 1e-8

    // (p0 -> p1) X (p0 -> p2)
    static func xmult(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x0: Double, _ y0: Double) -> Double {
        (x1 - x0) * (y2 - y0) - (x2 - x0) * (y1 - y0)
    }

    // (p0 -> p1) ⦁ (p0 -> p2)
    static func dmult(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x0: Double, _ y0: Double) -> Double {
        (x1 - x0) * (x2 - x0) + (y1 - y0) * (y2 - y0)
    }

    static func zero(_ x: Double) -> Bool {
        fabs(x) < eps
    }
}

fileprivate extension Geometry {
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

    struct Circle {
        var p: Point
        var r: Double
        init(_ p0: Point, _ r0: Double) { (p, r) = (p0, r0) }
    }
}

// MARK: 直线/线段
fileprivate extension Geometry {
    // (p0 -> p1) X (p0 -> p2)
    static func xmult(_ p1: Point, _ p2: Point, _ p0: Point) -> Double {
        (p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y)
    }

    // (p0 -> p1) ⦁ (p0 -> p2)
    static func dmult(_ p1: Point, _ p2: Point, _ p0: Point) -> Double {
        (p1.x - p0.x) * (p2.x - p0.x) + (p1.y - p0.y) * (p2.y - p0.y)
    }

    // 两点距离
    static func distance(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    }
    static func distance(_ p1: Point, _ p2: Point) -> Double {
        sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y))
    }

    // 三点共线
    static func dotsInLine(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x3: Double, _ y3: Double) -> Bool {
        zero(xmult(x1, y1, x2, y2, x3, y3))
    }
    static func dotsInLine(_ p1: Point, _ p2: Point, _ p3: Point) -> Bool {
        zero(xmult(p1, p2, p3))
    }

    // 点在线段上（含端点)
    // (x1 - x) * (x2 - x) <= eps 判断在线段内
    static func dotOnLine(_ x: Double, _ y: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Bool {
        zero(xmult(x, y, x1, y1, x2, y2)) &&
        ((x1 - x) * (x2 - x) < eps) &&
        ((y1 - y) * (y2 - y) < eps)
    }
    static func dotOnLine(_ p: Point, _ l: Line) -> Bool {
        zero(xmult(p, l.a, l.b)) &&
        ((l.a.x - p.x) * (l.b.x - p.x) < eps) &&
        ((l.a.y - p.y) * (l.b.y - p.y) < eps)
    }
    // 点在线段上（不含端点）
    static func dotOnLineEx(_ x: Double, _ y: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Bool {
        dotOnLine(x, y, x1, y1, x2, y2) &&
        (!zero(x - x1) || !zero(y - y1)) &&
        (!zero(x - x2) || !zero(y - y2))
    }
    static func dotOnLineEx(_ p: Point, _ l: Line) -> Bool {
        dotOnLine(p, l) &&
        (!zero(p.x - l.a.x) || !zero(p.y - l.a.y)) &&
        (!zero(p.x - l.b.x) || !zero(p.y - l.b.y))
    }

    // 两点在线段同侧
    static func pointSameSideOfLine(_ p1: Point, _ p2: Point, _ line: Line) -> Bool {
        xmult(line.a, p1, line.b) * xmult(line.a, p2, line.b) > 0
    }
    // 两点在线段异侧
    static func pointOppositeSideOfLine(_ p1: Point, _ p2: Point, _ line: Line) -> Bool {
        xmult(line.a, p1, line.b) * xmult(line.a, p2, line.b) < 0
    }

    // 直线平行
    // -> 直线不平行就是相交
    static func parallel(_ u: Line, _ v: Line) -> Bool {
        zero((u.a.x - u.b.x) * (v.a.y - v.b.y) - (v.a.x - v.b.x) * (u.a.y - u.b.y))
    }
    // 直线垂直
    static func perpendicular(_ u: Line, _ v: Line) -> Bool {
        zero((u.a.x - u.b.x) * (v.a.x - v.b.x) + (u.a.y - u.b.y) * (v.a.y - v.b.y))
    }

    // 线段相交 (含端点和部分重合)
    static func lineIntersect(_ u: Line, _ v: Line) -> Bool {
        if !dotsInLine(u.a, u.b, v.a) || !dotsInLine(u.a, u.b, v.b) {
            return !pointSameSideOfLine(u.a, u.b, v) && !pointSameSideOfLine(v.a, v.b, u)
        }
        return dotOnLine(u.a, v) || dotOnLine(u.b, v) || dotOnLine(v.a, u) || dotOnLine(v.b, u)
    }
    // 线段相关 (不含端点和部分重合)
    static func lineIntersectEx(_ u: Line, _ v: Line) -> Bool {
        pointOppositeSideOfLine(u.a, u.b, v) && pointOppositeSideOfLine(v.a, v.b, u)
    }

    /* 直线/线段 交点
    // 直线：不平行
    assert(!parallel(u, v))
    // 线段：相交
    assert(lineIntersect(u, v))
    */
    static func intersection(_ u: Line, _ v: Line) -> Point {
        var ret = u.a
        let t = ((u.a.x - v.a.x) * (v.a.y - v.b.y) - (u.a.y - v.a.y) * (v.a.x - v.b.x)) /
                ((u.a.x - u.b.x) * (v.a.y - v.b.y) - (u.a.y - u.b.y) * (v.a.x - v.b.x))
        ret.x += (u.b.x - u.a.x) * t
        ret.y += (u.b.y - u.a.y) * t
        return ret
    }

    // 点到直线最近点（垂点）
    static func pointToLine(_ p: Point, _ l: Line) -> Point {
        var t = p
        t.x += l.a.y - l.b.y
        t.y += l.b.x - l.a.x
        return intersection(Line(p, t), l)
    }
    // 点到直线距离
    static func distancePointToLine(_ p: Point, _ l: Line) -> Double {
        fabs(xmult(p, l.a, l.b)) / distance(l.a, l.b)
    }

    // 点到线段最近点（垂点/端点）
    static func pointToSegment(_ p: Point, _ l: Line) -> Point {
        var t = p
        t.x += l.a.y - l.b.y
        t.y += l.b.x - l.a.x
        if xmult(l.a, t, p) * xmult(l.b, t, p) > eps {
            return distance(p, l.a) < distance(p, l.b) ? l.a : l.b
        }
        return intersection(Line(p, t), l)
    }
    // 点到线段距离
    static func distancePointToSegment(_ p: Point, _ l: Line) -> Double {
        var t = p
        t.x += l.a.y - l.b.y
        t.y += l.b.x - l.a.x
        if xmult(l.a, t, p) * xmult(l.b, t, p) > eps {
            return min(distance(p, l.a), distance(p, l.b))
        }
        return fabs(xmult(p, l.a, l.b)) / distance(l.a, l.b)
    }


    /* 两点直线函数：y = k * x + b
     * @return (k, b)
     * 可以使用 "\(k)-\(b)" 作为 hash key 标识一条直线
     * 或者 hashable struct Point, 或者 [Int] 作为 key
     **/
    static func lineOfDots(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> (Double, Double) {
        var k, b: Double
        if fabs(x1 - x2) < eps {
            k = Double(Int.max)
            b = y1
        } else {
            k = (y2 - y1) / (x2 - x1)
            b = y1 - k * x1
        }
        return (k, b)
    }
}

// MARK: 圆
fileprivate extension Geometry {
    // 判断直线与圆相交（包括相切）
    static func intersectLineWithCircle(_ c: Circle, _ l: Line) -> Bool {
        distancePointToLine(c.p, l) < c.r + eps
    }

    // 判断线段与圆相交（包括端点与相切）
    static func intersectSegWithCircle(_ c: Circle, _ l: Line) -> Bool {
        let t1 = distance(c.p, l.a) - c.r
        let t2 = distance(c.p, l.b) - c.r
        if t1 < eps || t2 < eps {
            // 一个点在内，一个点在外
            return t1 > -eps || t2 > -eps
        }
        var t = c.p
        t.x += l.a.y - l.b.y
        t.y += l.b.x - l.a.x
        return xmult(l.a, c.p, t) * xmult(l.b, c.p, t) < eps && distancePointToLine(c.p, l) - c.r < eps
    }

    // 圆与圆相交
    static func intersectTwoCircle(_ c1: Circle, _ c2: Circle) -> Bool {
        distance(c1.p, c2.p) < c1.r + c2.r + eps &&
        distance(c1.p, c2.p) > fabs(c1.r - c2.r) - eps
    }

    // 圆上到点 p 的最近点（p 是圆心则直接返回）
    static func pointToCircle(_ p: Point, _ c: Circle) -> Point {
        let dist = distance(p, c.p)
        guard dist >= eps else { return p }
        var (u, v) = (Point(), Point())
        let flag: Double = (c.p.x - p.x) * (c.p.y * p.y) < 0 ? -1 : 1
        u.x = c.p.x + c.r * fabs(c.p.x - p.x) / dist
        u.y = (c.p.y + c.r * fabs(c.p.y - p.y) / dist) * flag
        v.x = c.p.x - c.r * fabs(c.p.x - p.x) / dist
        v.y = (c.p.y - c.r * fabs(c.p.y - p.y) / dist) * flag
        return distance(u, p) < distance(v, p) ? u : v
    }

    // 直线与圆的交点
    // 计算线段与圆的交点，可以先调用该方法，再判断结果是否在线段上
    static func intersectLineWithCircle(_ c: Circle, _ l: Line) -> (Point, Point) {
        var p = c.p
        p.x += l.a.y - l.b.y
        p.y += l.b.x - l.a.x
        p = intersection(Line(p, c.p), l)
        let t = sqrt(c.r * c.r - distance(p, c.p) * distance(p, c.p)) / distance(l.a, l.b)
        var (u, v) = (Point(), Point())
        u.x = p.x + (l.b.x - l.a.x) * t
        u.y = p.y + (l.b.y - l.a.y) * t
        v.x = p.x - (l.b.x - l.a.x) * t
        v.y = p.y - (l.b.y - l.a.y) * t
        return (u, v)
    }

    // 圆与圆的交点
    // 相交： assert(intersectTwoCircle(c1, c2) 且圆心不重合：distance(c1.p, c2.p) > eps
    static func intersectTwoCircle(_ c1: Circle, _ c2: Circle) -> (Point, Point) {
        var (u, v) = (Point(), Point())
        let dist = distance(c1.p, c2.p)
        assert(dist > eps)
        let t = (1 + (c1.r * c1.r - c2.r * c2.r) / (dist * dist)) / 2
        u.x = c1.p.x + (c2.p.x - c1.p.x) * t
        u.y = c1.p.y + (c2.p.y - c1.p.y) * t
        v.x = u.x + c1.p.y - c2.p.y
        v.y = u.y - c1.p.x + c2.p.x
        return intersectLineWithCircle(c1, Line(u, v))
    }
}

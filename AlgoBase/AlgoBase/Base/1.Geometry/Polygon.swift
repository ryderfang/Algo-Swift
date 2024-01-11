//
//  Polygon.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/31.
//

import Foundation

// MARK: Triangle
extension Geometry {
    // 三角形面积：输入三顶点
    func triArea(_ x0: Double, _ y0: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        fabs(xmult(x0, y0, x1, y1, x2, y2)) / 2.0
    }

    // 三角形面积：输入三条边（海伦公式）
    func triArea(_ a: Double, _ b: Double, _ c: Double) -> Double {
        let p = (a + b + c) / 2
        return sqrt(p * (p - a) * (p - b) * (p - c))
    }

    // MARK: 三角形四心 ❤️
    /* 外心: 三条边垂直平分线的交点
     - 外接圆的圆心，到各顶点距离相等
     */
    // 直线点法式，点(x0, y0), 法向量 (A, B) = (a.x - b.x, a.y - b.y)
    // A(x - x0) + B(y - y0) = 0
    func circumCenter(_ a: Point, _ b: Point, _ c: Point) -> Point {
        var u = Line()
        u.a = Point((a.x + b.x) / 2.0, (a.y + b.y) / 2.0)
        u.b.x = u.a.x - a.y + b.y
        u.b.y = u.a.y + a.x - b.x
        var v = Line()
        v.a = Point((a.x + c.x) / 2.0, (a.y + c.y) / 2.0)
        v.b.x = v.a.x - a.y + c.y
        v.b.y = v.a.y + a.x - c.x
        return intersection(u, v)
    }

    /* 内心: 三个角平分线的交点
     - 到三边距离相等
     */
    func inCenter(_ a: Point, _ b: Point, _ c: Point) -> Point {
        let A = distance(b, c)
        let B = distance(a, c)
        let C = distance(a, b)
        let S = A + B + C
        var pt = Point()
        pt.x = (A * a.x + B * b.x + C * c.x) / S
        pt.y = (A * a.y + B * b.y + C * c.y) / S
        return pt
    }
    // - 另一种算法
    func inCenter2(_ a: Point, _ b: Point, _ c: Point) -> Point {
        var u = Line()
        var m = atan2(b.y - a.y, b.x - a.x)
        var n = atan2(c.y - a.y, c.x - a.x)
        u.a = a
        u.b.x = u.a.x + cos((m + n) / 2)
        u.b.y = u.b.x + sin((m + n) / 2)
        var v = Line()
        v.a = b
        m = atan2(a.y - b.y, a.x - b.x)
        n = atan2(c.y - b.y, c.x - b.x)
        v.b.x = v.a.x + cos((m + n) / 2)
        v.b.y = v.b.x + sin((m + n) / 2)
        return intersection(u, v)
    }

    /* 重心: 三条中线的交点
     - 到三顶点距离的*平方和*最小的点
     - 到三顶点距离之积最大的点
     */
    func baryCenter(_ a: Point, _ b: Point, _ c: Point) -> Point {
        Point([(a.x + b.x + c.x) / 3.0, (a.y + b.y + c.y) / 3.0])
    }
    // - 另一种算法
    func baryCenter2(_ a: Point, _ b: Point, _ c: Point) -> Point {
        let u = Line(Point((a.x + b.x) / 2.0, (a.y + b.y) / 2.0), c)
        let v = Line(Point((a.x + c.x) / 2.0, (a.y + c.y) / 2.0), b)
        return intersection(u, v)
    }

    // 垂心: 三条高的交点
    func orthoCenter(_ a: Point, _ b: Point, _ c: Point) -> Point {
        var u = Line()
        u.a = c
        u.b.x = u.a.x - a.y + b.y
        u.b.y = u.a.y + a.x - b.x
        var v = Line()
        v.a = b
        v.b.x = v.a.x - a.y + c.y
        v.b.y = v.a.y + a.x - c.x
        return intersection(u, v)
    }

    /* 费马点: 到三个角距离之和最小的点 P
     - 如果三角形有一个角 > 120˚，这个角就是费马点
     - 否则，以三个边 AB/AC/BC 向外作等边三角形 ABC1/ACB1/BCA1，三条线 AA1/BB1/CC1 的交点即为费马点
     - ∠APB = ∠BPC = ∠APC = 120˚
     */
    // 更一般是 n 个点的费马点 (lc1515)
    func fermetPoint(_ a: Point, _ b: Point, _ c: Point, _ eps: Double = 1e-10) -> Point {
        // 初始点在重心
        var p0 = Point((a.x + b.x + c.x) / 3, (a.y + b.y + c.y) / 3)
        var step: Double = fabs(a.x) + fabs(a.y) + fabs(b.x) + fabs(b.y) + fabs(c.x) + fabs(c.y)
        let d: [(Double, Double)] = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        while step > eps {
            for _ in 0..<10 {
                for i in 0..<d.count {
                    let p1 = Point(p0.x + step * d[i].0, p0.y + step * d[i].1)
                    if distance(p1, a) + distance(p1, b) + distance(p1, c) <
                        distance(p0, a) + distance(p0, b) + distance(p0, c) {
                        p0 = p1
                    }
                }
                step /= 2
            }
        }
        return p0
    }
}

// MARK: Rect
extension Geometry {
    // 平行于坐标轴的两个矩形相交 (lc836)
    // rect = (x1,y1,x2,y2): (x1,y1) -> bottom-left, (x2,y2) -> top-right
    func isRectangleOverlap(_ rect1: [Int], _ rect2: [Int]) -> Bool {
        return (rect1[0]..<rect1[2]).overlaps(rect2[0]..<rect2[2]) &&
               (rect1[1]..<rect1[3]).overlaps(rect2[1]..<rect2[3])
    }

    // 相交部分面积 (lc223)
    func overlapArea(_ rect1: [Int], _ rect2: [Int]) -> Int {
        let width = (rect1[0]..<rect1[2]).clamped(to: rect2[0]..<rect2[2]).count
        let height = (rect1[1]..<rect1[3]).clamped(to: rect2[1]..<rect2[3]).count
        return width * height
    }

    // 矩形面积：输入相邻三个点, p0->p1 垂直 p0->p2
    func rectArea(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Int {
        abs(xmult(p0, p1, p2))
    }

    // Forth point of a rect, p0->p1 垂直 p0->p2
    func forthPointOfRect(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> [Int] {
        [p1[0] + p2[0] - p0[0], p1[1] + p2[1] - p0[1]]
    }

    // 矩形与圆相交 (lc1401)

    // 四点组成正方形 (lc593)
}

//
//  Geometry-Int.swift
//  AlgoBase
//
//  Created by ryfang on 2023/12/29.
//

import Foundation

extension Geometry {
    /* 向量叉乘/外积(cross product) -> 是一个向量（右手法则），计算的是它的模 (三维向量的 z 轴长)
     * 平等四边形（垂直 = 矩形）面积
     * a: p0 -> p1
     * b: p0 -> p2
     2D: a x b = |a| * |b| * sin(α) = x1 * y2 - x2 * y1 = (0, 0, x1 * y2 - x2 * y1)
     3D: a x b = (y1 * z2 - z1 * y2, z1 * x2 - x1 * z2, x1 * y2 - y1 * x2)
     * < 0 b 在 a 的顺时针方向
     * = 0 共线
     * > 0 b 在 a 的逆时针方向
     */
    static func xmult(_ p1: [Int], _ p2: [Int], _ p0: [Int]) -> Int {
        (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])
    }

    /* 向量点乘/内积(dot product) -> 是一个标量
     * a: p0 -> p1
     * b: p0 -> p2
     2D: a ⦁ b = |a| * |b| * cos(α) = x1 * x2 + y1 * y2
     3D: a ⦁ b = x1 * x2 + y1 * y2 + z1 * z2
     * < 0 方向相反，夹角在 (90˚, 180˚) 之间
     * = 0 垂直
     * > 0 方向相同，夹角在 (0˚, 90˚) 之间
     */
    static func dmult(_ p1: [Int], _ p2: [Int], _ p0: [Int]) -> Int {
        (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])
    }

    // 避免相乘越界
    static func sign(_ i: Int) -> Int {
        i > 0 ? 1 : (i < 0 ? -1 : 0)
    }
}

fileprivate extension Geometry {
    // make it internal hashable
    struct Point: Hashable {
        var x: Int
        var y: Int
        init(_ i: Int, _ j: Int ) { (x, y) = (i, j) }
        init(_ p: [Int]) { (x, y) = (p[0], p[1]) }
    }

    struct Line {
        var a: Point
        var b: Point
        init(_ p0: Point, _ p1: Point) { (a, b) = (p0, p1) }
    }
}

// MARK: 点/线
fileprivate extension Geometry {
    // (p0 -> p1) X (p0 -> p2)
    static func xmult(_ p1: Point, _ p2: Point, _ p0: Point) -> Int {
        (p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y)
    }

    // (p0 -> p1) ⦁ (p0 -> p2)
    static func dmult(_ p1: Point, _ p2: Point, _ p0: Point) -> Int {
        (p1.x - p0.x) * (p2.x - p0.x) + (p1.y - p0.y) * (p2.y - p0.y)
    }

    // 三点共线 (lc1037/lc1232)
    static func dotsInLine(_ p1: Point, _ p2: Point, _ p3: Point) -> Bool {
        xmult(p1, p2, p3) == 0
    }

    // 点在线段上 (含端点)
    // (x1 - x) * (x2 - x) <= 0 判断在线段内
    static func dotOnLine(_ p: Point, _ line: Line) -> Bool {
        (xmult(p, line.a, line.b) == 0) &&
        ((line.a.x - p.x) * (line.b.x - p.x) <= 0) &&
        ((line.a.y - p.y) * (line.b.y - p.y) <= 0)
    }
    // 点在线段上（不含端点）
    static func dotOnLineEx(_ p: Point, _ line: Line) -> Bool {
        dotOnLine(p, line) &&
        (p.x != line.a.x || p.y != line.a.y) &&
        (p.x != line.b.x || p.y != line.b.y)
    }

    // 两点在线段同侧
    // -> 返回 0 表示在直线上
    static func pointSameSideOfLine(_ p1: Point, _ p2: Point, _ line: Line) -> Bool {
        sign(xmult(line.a, p1, line.b)) * xmult(line.a, p2, line.b) > 0
    }
    // 两点在线段异侧
    static func pointOppositeSideOfLine(_ p1: Point, _ p2: Point, _ line: Line) -> Bool {
        sign(xmult(line.a, p1, line.b)) * xmult(line.a, p2, line.b) < 0
    }

    // 直线平行
    // -> 直线不平行就是相交
    static func parallel(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
        (u1[0] - u2[0]) * (v1[1] - v2[1]) == (v1[0] - v2[0]) * (u1[1] - u2[1])
    }
    static func parallel(_ u1: Point, _ u2: Point, _ v1: Point, _ v2: Point) -> Bool {
        (u1.x - u2.x) * (v1.y - v2.y) == (v1.x - v2.x) * (u1.y - u2.y)
    }
    static func parallel(_ u: Line, _ v: Line) -> Bool {
        (u.a.x - u.b.x) * (v.a.y - v.b.y) == (v.a.x - v.b.x) * (u.a.y - u.b.y)
    }

    // 直线垂直
    static func perpendicular(_ u1: [Int], _ u2: [Int], _ v1: [Int], _ v2: [Int]) -> Bool {
        (u1[0] - u2[0]) * (v1[0] - v2[0]) + (u1[1] - u2[1]) * (v1[1] - v2[1]) == 0
    }
    static func perpendicular(_ u1: Point, _ u2: Point, _ v1: Point, _ v2: Point) -> Bool {
        (u1.x - u2.x) * (v1.x - v2.x) + (u1.y - u2.y) * (v1.y - v2.y) == 0
    }
    static func perpendicular(_ u: Line, _ v: Line) -> Bool {
        (u.a.x - u.b.x) * (v.a.x - v.b.x) + (u.a.y - u.b.y) * (v.a.y - v.b.y) == 0
    }

    // 线段相交 (含端点和部分重合)
    static func lineIntersect(_ u: Line, v: Line) -> Bool {
        if !dotsInLine(u.a, u.b, v.a) || !dotsInLine(u.a, u.b, v.b) {
            return !pointSameSideOfLine(u.a, u.b, v) && !pointSameSideOfLine(v.a, v.b, u)
        }
        return dotOnLine(u.a, v) || dotOnLine(u.b, v) || dotOnLine(v.a, u) || dotOnLine(v.b, u)
    }
    // 线段相关 (不含端点和部分重合)
    static func lineIntersectEx(_ u: Line, v: Line) -> Bool {
        return pointOppositeSideOfLine(u.a, u.b, v) && pointOppositeSideOfLine(v.a, v.b, u)
    }
}

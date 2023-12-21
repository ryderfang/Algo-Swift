//
//  Geometry.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/23.
//

import Foundation

// 计算几何
class Geometry {
    static var eps: Double = 1e-8
    /* 向量叉乘/外积(cross product) -> 是一个向量（右手法则），计算的是它的模 (三维向量的 z 轴长)
     2D: a x b = |a| * |b| * sin(α) = x1 * y2 - x2 * y1 = (0, 0, x1 * y2 - x2 * y1)
     3D: a x b = (y1 * z2 - z1 * y2, z1 * x2 - x1 * z2, x1 * y2 - y1 * x2)
     * < 0 b 在 a 的顺时针方向
     * = 0 共线
     * > 0 b 在 a 的逆时针方向
     */
    static func xmult(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Int {
        (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])
    }

    static func xmult(_ x0: Double, _ y0: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        (x1 - x0) * (y2 - y0) - (x2 - x0) * (y1 - y0)
    }

    /* 向量点乘/内积(dot product) -> 是一个标量
     2D: a ⦁ b = |a| * |b| * cos(α) = x1 * x2 + y1 * y2
     3D: a ⦁ b = x1 * x2 + y1 * y2 + z1 * z2
     * < 0 方向相反，夹角在 (90˚, 180˚) 之间
     * = 0 垂直
     * > 0 方向相同，夹角在 (0˚, 90˚) 之间
     */
    static func dmult(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Int {
        (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1])
    }

    static func dmult(_ x0: Double, _ y0: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        (x1 - x0) * (x2 - x0) + (y1 - y0) * (y2 - y0)
    }

    static func zero(_ x: Double) -> Bool {
        fabs(x) < eps
    }
}

extension Geometry {
    // make it internal hashable
    struct Point: Hashable {
        public var x: Double
        public var y: Double

        init(_ i: Int, _ j: Int ) {
            self.x = Double(i)
            self.y = Double(j)
        }
    }
    struct Line {
        public var a: Point
        public var b: Point
    }
}

// MARK: 二维
extension Geometry {
    // 三点共线 (lc1037/lc1232)
    static func checkStraightLine(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Bool {
        xmult(p0, p1, p2) == 0
    }

    // 两点距离
    static func distance(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    }

    // 点在线段上（含端点）: Point(x,y), Line(Point(x1, y1), Point(x2, y2))
    // (x1 - x) * (x2 - x) <= eps 判断在线段内
    static func dotOnLine(_ x: Double, _ y: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Bool {
        zero(xmult(x, y, x1, y1, x2, y2)) &&
        ((x1 - x) * (x2 - x) <= eps) &&
        ((y1 - y) * (y2 - y) <= eps)
    }
    // 点在线段上（不含端点）
    static func dotOnLine_Ex(_ x: Double, _ y: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Bool {
        dotOnLine(x, y, x1, y1, x2, y2) &&
        !(zero(x - x1) && zero(y - y1)) &&
        !(zero(x - x2) && zero(y - y2))
    }

    /* 两点直线函数：y = k * x + b
     * @return (k, b)
     * 可以使用 "\(k)-\(b)" 作为 hash key 标识一条直线
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

    // 三角形面积：输入三顶点
    static func triArea(_ x0: Double, _ y0: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        fabs(xmult(x0, y0, x1, y1, x2, y2)) / 2.0
    }
    // 三角形面积：输入三条边（海伦公式）
    static func triArea(_ a: Double, _ b: Double, _ c: Double) -> Double {
        let p = (a + b + c) / 2
        return sqrt(p * (p - a) * (p - b) * (p - c))
    }
}

// MARK: 三维
extension Geometry {

}

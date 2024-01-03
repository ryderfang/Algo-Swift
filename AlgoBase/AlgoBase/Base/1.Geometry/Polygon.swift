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
    static func triArea(_ x0: Double, _ y0: Double, _ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        fabs(xmult(x0, y0, x1, y1, x2, y2)) / 2.0
    }

    // 三角形面积：输入三条边（海伦公式）
    static func triArea(_ a: Double, _ b: Double, _ c: Double) -> Double {
        let p = (a + b + c) / 2
        return sqrt(p * (p - a) * (p - b) * (p - c))
    }
}

// MARK: Rect
extension Geometry {
    // 平行于坐标轴的两个矩形相交 (lc836)
    // rect = (x1,y1,x2,y2): (x1,y1) -> bottom-left, (x2,y2) -> top-right
    static func isRectangleOverlap(_ rect1: [Int], _ rect2: [Int]) -> Bool {
        return (rect1[0]..<rect1[2]).overlaps(rect2[0]..<rect2[2]) &&
               (rect1[1]..<rect1[3]).overlaps(rect2[1]..<rect2[3])
    }

    // 相交部分面积 (lc223)
    static func overlapArea(_ rect1: [Int], _ rect2: [Int]) -> Int {
        let width = (rect1[0]..<rect1[2]).clamped(to: rect2[0]..<rect2[2]).count
        let height = (rect1[1]..<rect1[3]).clamped(to: rect2[1]..<rect2[3]).count
        return width * height
    }

    // 矩形面积：输入相邻三个点, p0->p1 垂直 p0->p2
    static func rectArea(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Int {
        abs(xmult(p0, p1, p2))
    }

    // Forth point of a rect, p0->p1 垂直 p0->p2
    static func forthPointOfRect(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> [Int] {
        [p1[0] + p2[0] - p0[0], p1[1] + p2[1] - p0[1]]
    }

    // 矩形与圆相交 (lc1401)

    // 四点组成正方形 (lc593)
}

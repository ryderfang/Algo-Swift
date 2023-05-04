//
//  Polygon.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/31.
//

import Foundation

// 多边形
class Polygon {

}

// MARK: Rect
extension Polygon {
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
}

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
    static func isRectangleOverlap(_ rec1: [Int], _ rec2: [Int]) -> Bool {
        return (rec1[0]..<rec1[2]).overlaps(rec2[0]..<rec2[2]) &&
               (rec1[1]..<rec1[3]).overlaps(rec2[1]..<rec2[3])
    }
}

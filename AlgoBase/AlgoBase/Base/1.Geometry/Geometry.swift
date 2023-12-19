//
//  Geometry.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/23.
//

import Foundation

// 计算几何
class Geometry {
    struct Point {
        public var x: Double
        public var y: Double

        init(_ x: Double, _ y: Double) {
            self.x = x
            self.y = y
        }

        init(_ i: Int, _ j: Int ) {
            self.x = Double(i)
            self.y = Double(j)
        }
    }

    struct Line {
        func inSameLine(_ points: [[Int]]) -> Bool {
            let vec1 = (points[1][0] - points[0][0], points[1][1] - points[0][1])
            let vec2 = (points[2][0] - points[0][0], points[2][1] - points[0][1])
            return (vec1.0 * vec2.1 - vec1.1 * vec2.0) == 0
        }
    }

    struct Area {
        // cross product (p3->p1) x (p3->p2)
        static func xprod(_ p1: Point, _ p2: Point, _ p3: Point) -> Double {
            return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)
        }

        static func xprod(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x3: Double, _ y3: Double) -> Double {
            return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)
        }

        // area of triangle
        static func triArea(p1: Point, p2: Point, p3: Point) -> Double {
            return fabs(xprod(p1, p2, p3)) / 2
        }

        static func triArea(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) -> Double {
            return fabs(xprod(x1, y1, x2, y2, x3, y3)) / 2
        }

        static func triArea(_ p1: [Int], _ p2: [Int], _ p3: [Int]) -> Double {
            let (x1, y1) = (Double(p1[0]), Double(p1[1]))
            let (x2, y2) = (Double(p2[0]), Double(p2[1]))
            let (x3, y3) = (Double(p3[0]), Double(p3[1]))
            return fabs((x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)) / 2
        }
    }
}

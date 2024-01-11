//
//  ConvexHull.swift
//  AlgoBase
//
//  Created by ryfang on 2024/1/3.
//

import Foundation

// 凸包问题 (lc587)
// 二维欧氏几何：包含所有点的最小的凸多边形
extension Geometry {
    // public func atan2(_ __y: Double, _ __x: Double) -> Double
    func _theta(_ p: PointI) -> Double {
        if p.x == 0 && p.y == 0 {
            return -Double.infinity
        }
        return atan2(Double(p.y), Double(p.x))
    }

    func _xmult(_ p1: PointI, _ p2: PointI, _ p3: PointI) -> Int {
        (p2.x - p1.x) * (p3.y - p2.y) - (p3.x - p2.x) * (p2.y - p1.y)
    }

    func _dist(_ p0: PointI, _ p1: PointI) -> Int {
        (p1.x - p0.x) * (p1.x - p0.x) + (p1.y - p0.y) * (p1.y - p0.y)
    }

    // 判断 p1 -> p2 到 p2 -> p3 是不是逆时针
    func _antiClockwise(_ p1: PointI, _ p2: PointI, _ p3: PointI) -> Bool {
        _xmult(p1, p2, p3) > 0
    }

    /* Graham scan https://en.wikipedia.org/wiki/Graham_scan
     // @Pseudocode
     let points be the list of points
     let stack = empty_stack()

     find the lowest y-coordinate and leftmost point, called P0
     sort points by polar angle with P0, if several points have the same polar angle then only keep the farthest

     for point in points:
         # pop the last point from the stack if we turn clockwise to reach this point
         while count stack > 1 and ccw(next_to_top(stack), top(stack), point) <= 0:
             pop stack
         push point to stack
     end
    */
    func graham(_ points: [PointI]) -> [PointI] {
        let n = points.count
        guard n > 2 else { return points }
        // 起点 (leftmost & lowest OR lowest & leftmost)
        let p0 = points.sorted(by: { $0.x < $1.x || ($0.x == $1.x && $0.y < $1.y) })[0]
        // 极坐标排序
        let ps = points.sorted { p1, p2 in
            let theta1 = _theta(PointI(p1.x - p0.x, p1.y - p0.y))
            let theta2 = _theta(PointI(p2.x - p0.x, p2.y - p0.y))
            if theta1 < theta2 { return true }
            // 共线点按距离排序
            if _xmult(p0, p1, p2) == 0 {
                return _dist(p0, p1) < _dist(p0, p2)
            }
            return false
        }
        var stack: [PointI] = [ps[0]]
        for i in 1..<n {
            while stack.count > 1 && !_antiClockwise(stack[stack.count - 2], stack[stack.count - 1], ps[i]) {
                stack.removeLast()
            }
            stack.append(ps[i])
        }
        // 剩余共线点 (如果明确没有共线点，直接返回 stack 即可)
        var total = Set<PointI>(stack)
        for i in 0..<n {
            guard !total.contains(ps[i]) else { continue }
            var checked = false
            let m = stack.count
            for j in 0..<m {
                if _xmult(ps[i], stack[j], stack[(j+1)%m]) == 0 {
                    checked = true
                    break
                }
            }
            if checked {
                total.insert(ps[i])
            }
        }
        return Array(total)
    }

    /* Andrew's algorithm
     与 Graham 算法不同的是，不需要按极坐标排序
     而是分成两次扫描，分别求出上凸包和下凸包
     */
    func andrew(_ points: [PointI]) -> [PointI] {
        let n = points.count
        guard n > 2 else { return points }
        // 起点
        let ps = points.sorted(by: { $0.x < $1.x || ($0.x == $1.x && $0.y < $1.y) })
        let p0 = ps[0]
        var stack: [PointI] = [p0]
        var visited = Set<PointI>()
        // 顺序
        for i in 1..<n {
            // 保留了共线的点
            while stack.count > 1 && _xmult(stack[stack.count - 2], stack[stack.count - 1], ps[i]) < 0 {
                let last = stack.removeLast()
                visited.remove(last)
            }
            stack.append(ps[i])
            visited.insert(ps[i])
        }
        // 逆序
        for i in stride(from: n-1, through: 0, by: -1) {
            guard !visited.contains(ps[i]) else { continue }
            // 保留了共线的点
            while stack.count > 1 && _xmult(stack[stack.count - 2], stack[stack.count - 1], ps[i]) < 0 {
                stack.removeLast()
            }
            stack.append(ps[i])
        }
        // 去除重复的起点 (逆序时为了回到起点被加入了两次)
        stack.removeFirst()
        return stack
    }
}


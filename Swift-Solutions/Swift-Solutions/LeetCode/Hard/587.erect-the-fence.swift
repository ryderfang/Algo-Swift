/*
 * @lc app=leetcode id=587 lang=swift
 *
 * [587] Erect the Fence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 凸包问题 (含共线点)
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
    func outerTrees(_ trees: [[Int]]) -> [[Int]] {
        struct Point: Hashable {
            var x: Int
            var y: Int
            init(_ i: Int, _ j: Int ) { (x, y) = (i, j) }
            init(_ p: [Int]) { (x, y) = (p[0], p[1]) }
        }

        func _theta(_ p: Point) -> Double {
            if p.x == 0 && p.y == 0 {
                return -Double.infinity
            }
            return atan2(Double(p.y), Double(p.x))
        }

        func _xmult(_ p1: Point, _ p2: Point, _ p3: Point) -> Int {
            (p2.x - p1.x) * (p3.y - p2.y) - (p3.x - p2.x) * (p2.y - p1.y)
        }

        func _dist(_ p0: Point, _ p1: Point) -> Int {
            (p1.x - p0.x) * (p1.x - p0.x) + (p1.y - p0.y) * (p1.y - p0.y)
        }

        // 判断 p1 -> p2 到 p2 -> p3 是不是逆时针
        func _antiClockwise(_ p1: Point, _ p2: Point, _ p3: Point) -> Bool {
            _xmult(p1, p2, p3) > 0
        }

        let n = trees.count
        guard n > 2 else { return trees }
        // 起点 (leftmost & lowest OR lowest & leftmost)
        let points = trees.map { Point($0) }
        let p0 = points.sorted(by: { $0.x < $1.x || ($0.x == $1.x && $0.y < $1.y) })[0]
        // 极坐标排序
        let ps = points.sorted { p1, p2 in
            let theta1 = _theta(Point(p1.x - p0.x, p1.y - p0.y))
            let theta2 = _theta(Point(p2.x - p0.x, p2.y - p0.y))
            if theta1 < theta2 { return true }
            // 共线点按距离排序
            if _xmult(p0, p1, p2) == 0 {
                return _dist(p0, p1) < _dist(p0, p2)
            }
            return false
        }
        var stack: [Point] = [ps[0]]
        for i in 1..<n {
            while stack.count > 1 && !_antiClockwise(stack[stack.count - 2], stack[stack.count - 1], ps[i]) {
                stack.removeLast()
            }
            stack.append(ps[i])
        }
        // 剩余共线点
        var total = Set<Point>(stack)
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
        return total.map { [$0.x, $0.y] }
    }

    /* Andrew's algorithm
     与 Graham 算法不同的是，不需要按极坐标排序
     而是分成两次扫描，分别求出上凸包和下凸包
     */
    func outerTrees2(_ trees: [[Int]]) -> [[Int]] {
        struct Point: Hashable {
            var x: Int
            var y: Int
            init(_ i: Int, _ j: Int ) { (x, y) = (i, j) }
            init(_ p: [Int]) { (x, y) = (p[0], p[1]) }
        }

        func _xmult(_ p1: Point, _ p2: Point, _ p3: Point) -> Int {
            (p2.x - p1.x) * (p3.y - p2.y) - (p3.x - p2.x) * (p2.y - p1.y)
        }

        // 判断 p1 -> p2 到 p2 -> p3 是不是逆时针 (或共线)
        func _antiClockwise(_ p1: Point, _ p2: Point, _ p3: Point) -> Bool {
            _xmult(p1, p2, p3) >= 0
        }

        let n = trees.count
        guard n > 2 else { return trees }
        // 起点
        let points = trees.map { Point($0) }
        let ps = points.sorted(by: { $0.x < $1.x || ($0.x == $1.x && $0.y < $1.y) })
        let p0 = ps[0]
        var stack: [Point] = [p0]
        var visited = Set<Point>()
        // 顺序
        for i in 1..<n {
            while stack.count > 1 && !_antiClockwise(stack[stack.count - 2], stack[stack.count - 1], ps[i]) {
                let last = stack.removeLast()
                visited.remove(last)
            }
            stack.append(ps[i])
            visited.insert(ps[i])
        }
        // 逆序
        for i in stride(from: n-1, through: 0, by: -1) {
            guard !visited.contains(ps[i]) else { continue }
            while stack.count > 1 && !_antiClockwise(stack[stack.count - 2], stack[stack.count - 1], ps[i]) {
                stack.removeLast()
            }
            stack.append(ps[i])
        }
        // 去除重复的起点 (逆序时为了回到起点被加入了两次)
        stack.removeFirst()
        return stack.map { [$0.x, $0.y] }
    }
}
// @lc code=end

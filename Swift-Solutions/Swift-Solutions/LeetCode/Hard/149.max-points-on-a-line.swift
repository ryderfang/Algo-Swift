/*
 * @lc app=leetcode id=149 lang=swift
 *
 * [149] Max Points on a Line
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: gradient hash
    func maxPoints(_ points: [[Int]]) -> Int {
        guard points.count > 2 else { return points.count }

        var map: [String: Set<Int>] = [:]
        var max = 0

        for i in 0..<points.count {
            if i + 1 >= points.count { break }

            for j in i+1..<points.count {
                let line = lineOfTwoPoint(i, j, points)
                let key = "\(line.0)-\(line.1)"
                var indexs = map[key] != nil ? map[key]! : Set<Int>()

                indexs.insert(i)
                indexs.insert(j)
                map[key] = indexs
                max = max > map[key]!.count ? max : map[key]!.count
            }
        }

        return max
    }

    // y = kx + a, idx0, idx1
    func lineOfTwoPoint(_ idx0: Int, _ idx1: Int, _ points: [[Int]]) -> (Double, Double) {
        let p0 = points[idx0]
        let p1 = points[idx1]
        var k, a: Double

        if p0[1] == p1[1] {
            k = 0
            a = Double(p0[1])

        } else if p0[0] == p1[0] {
            k = Double(Int.max)
            a = Double(p0[0])

        } else {

            k = Double(p0[1] - p1[1]) / Double(p0[0] - p1[0])
            a = Double(p0[1]) - k * Double(p0[0])
        }

        return (k, a)
    }

    func maxPoints1(_ points: [[Int]]) -> Int {
        let n = points.count
        guard n > 2 else { return n }
        func _idx(_ i: Int, _ j: Int) -> Int {
            if i < j {
                return i * n + j
            } else {
                return j * n + i
            }
        }
        func _oneLine(_ p0: [Int], _ p1: [Int], _ p2: [Int]) -> Bool {
            (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1]) == 0
        }
        var checked = Set<Int>()
        var ans = 0
        for i in 0..<n-2 {
            for j in i+1..<n-1 {
                guard i != j && !checked.contains(_idx(i, j)) else { continue }
                var tmp = 2
                checked.insert(_idx(i, j))
                let p0 = points[i], p1 = points[j]
                for k in j+1..<n {
                    guard k != i && k != j && !checked.contains(_idx(i, k)) && !checked.contains(_idx(j, k)) else { continue }
                    let p2 = points[k]
                    if _oneLine(p0, p1, p2) {
                        checked.insert(_idx(i, k))
                        checked.insert(_idx(j, k))
                        tmp += 1
                    }
                }
                ans = max(ans, tmp)
            }
        }
        return ans
    }
}
// @lc code=end


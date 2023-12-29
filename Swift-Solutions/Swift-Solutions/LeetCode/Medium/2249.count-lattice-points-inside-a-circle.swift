/*
 * @lc app=leetcode id=2249 lang=swift
 *
 * [2249] Count Lattice Points Inside a Circle
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countLatticePoints(_ circles: [[Int]]) -> Int {
        var ans = Set<Point>()
        for circle in circles {
            let (x0, y0, r0) = (circle[0], circle[1], circle[2])
            for i in x0-r0...x0+r0 {
                for j in y0-r0...y0+r0 {
                    if (i - x0) * (i - x0) + (j - y0) * (j - y0) <= r0 * r0 {
                        ans.insert(Point(i, j))
                    }
                }
            }
        }
        return ans.count
    }
}

fileprivate struct Point: Hashable {
    var x: Int
    var y: Int
    init(_ i: Int, _ j: Int) {
        (x, y) = (i, j)
    }
    init(_ p: [Int]) {
        (x, y) = (p[0], p[1])
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=1828 lang=swift
 *
 * [1828] Queries on Number of Points Inside a Circle
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countPoints(_ points: [[Int]], _ queries: [[Int]]) -> [Int] {
        var ans = [Int]()
        func _isInside(_ circle: [Int], _ p: [Int]) -> Bool {
            (p[0] - circle[0]) * (p[0] - circle[0]) + (p[1] - circle[1]) * (p[1] - circle[1]) <= circle[2] * circle[2]
        }
        for q in queries {
            var tmp = 0
            for p in points {
                if _isInside(q, p) {
                    tmp += 1
                }
            }
            ans.append(tmp)
        }
        return ans
    }
}
// @lc code=end


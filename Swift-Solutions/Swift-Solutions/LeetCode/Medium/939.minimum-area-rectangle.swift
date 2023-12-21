/*
 * @lc app=leetcode id=939 lang=swift
 *
 * [939] Minimum Area Rectangle
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Another method: enumerate diagonal point pair (枚举对角线两点)
    // parallel to axes
    func minAreaRect(_ points: [[Int]]) -> Int {
        var pmap = [String: Bool]()
        var xp = [Int: Set<Int>]()
        var yp = [Int: Set<Int>]()
        for p in points {
            pmap["\(p[0])-\(p[1])"] = true
            if xp[p[0]] == nil {
                xp[p[0]] = Set([p[1]])
            } else {
                xp[p[0]]?.insert(p[1])
            }
            if yp[p[1]] == nil {
                yp[p[1]] = Set([p[0]])
            } else {
                yp[p[1]]?.insert(p[0])
            }
        }
        let xkeys = xp.keys.filter({ (xp[$0]?.count ?? 0) > 1 })
        let ykeys = yp.keys.filter({ (yp[$0]?.count ?? 0) > 1 })
        guard xkeys.count > 1 && ykeys.count > 1 else { return 0 }
        var ans = Int.max
        for i in 0..<xkeys.count-1 {
            for j in i+1..<xkeys.count {
                for k in 0..<ykeys.count-1 {
                    for l in k+1..<ykeys.count {
                        let (x1, x2) = (xkeys[i], xkeys[j])
                        let (y1, y2) = (ykeys[k], ykeys[l])
                        guard pmap["\(x1)-\(y1)", default: false] && pmap["\(x1)-\(y2)", default: false] &&
                               pmap["\(x2)-\(y1)", default: false] && pmap["\(x2)-\(y2)", default: false] else {
                            continue
                        }
                        ans = min(ans, abs(x2 - x1) * abs(y2 - y1))
                    }
                }
            }
        }
        return ans == Int.max ? 0 : ans
    }
}
// @lc code=end

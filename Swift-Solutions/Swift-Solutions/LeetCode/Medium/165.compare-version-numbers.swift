/*
 * @lc app=leetcode id=165 lang=swift
 *
 * [165] Compare Version Numbers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        var v1 = version1.components(separatedBy: ".").map { return Int($0) ?? 0 }
        var v2 = version2.components(separatedBy: ".").map { return Int($0) ?? 0 }
        let n = max(v1.count, v2.count)
        if v1.count < v2.count {
            v1.append(contentsOf: [Int](repeating: 0, count: n - v1.count))
        } else if v1.count > v2.count {
            v2.append(contentsOf: [Int](repeating: 0, count: n - v2.count))
        }
        for i in 0..<n {
            guard v1[i] != v2[i] else { continue }
            if v1[i] < v2[i] {
                return -1
            } else {
                return 1
            }
        }
        return 0
    }
}
// @lc code=end


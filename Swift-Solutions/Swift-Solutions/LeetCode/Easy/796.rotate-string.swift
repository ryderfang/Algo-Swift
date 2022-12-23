/*
 * @lc app=leetcode id=796 lang=swift
 *
 * [796] Rotate String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func rotateString(_ s: String, _ goal: String) -> Bool {
        guard s.count == goal.count else { return false }
        guard let g0 = goal.first else { return false }
        let n = goal.count
        for (i, ch) in s.enumerated() {
            if ch == g0 {
                if s[i..<n] + s[0..<i] == goal {
                    return true
                }
            }
        }
        return false
    }
}

fileprivate extension String {
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }
}

// @lc code=end

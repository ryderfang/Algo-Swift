/*
 * @lc app=leetcode id=390 lang=swift
 *
 * [390] Elimination Game
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func lastRemaining(_ n: Int) -> Int {
        var stack = [(Int, Bool)]()
        var t = n
        var left = true
        while t > 1 {
            stack.append((t, left))
            t /= 2
            left = !left
        }
        var idx = 0
        while let last = stack.popLast() {
            if last.1 {
                idx = idx * 2 + 1
            } else {
                if last.0 % 2 == 0 {
                    idx = 2 * idx
                } else {
                    idx = idx * 2 + 1
                }
            }
        }
        return idx + 1
    }
}
// @lc code=end

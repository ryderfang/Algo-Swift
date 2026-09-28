/*
 * @lc app=leetcode id=598 lang=swift
 *
 * [598] Range Addition II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maxCount(_ m: Int, _ n: Int, _ ops: [[Int]]) -> Int {
        return (ops.map { $0[0] }.min() ?? m) * (ops.map { $0[1] }.min() ?? n)
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=1137 lang=swift
 *
 * [1137] N-th Tribonacci Number
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 尾递归优化
    func tribonacci(_ n: Int) -> Int {
        func _iter(_ n: Int, _ t: [Int] = [0, 1, 1]) -> Int {
            guard n > 2 else { return t[n] }
            return _iter(n - 1, [t[1], t[2], t[0] + t[1] + t[2]])
        }
        return _iter(n)
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=172 lang=swift
 *
 * [172] Factorial Trailing Zeroes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // n 的阶乘结果中末尾 0 的个数
    // 其实就是 1-n 中能分解出 5 的个数，因为 2 的个数足够
    func trailingZeroes(_ n: Int) -> Int {
        guard n > 0 else { return 0}
        return Array(1...n).reduce(0) { x, y in
            var y = y
            var count = 0
            while y % 5 == 0 {
                y /= 5
                count += 1
            }
            return x + count
        }
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=509 lang=swift
 *
 * [509] Fibonacci Number
 */

// @lc code=start
extension Solution {
    // 尾递归优化
    func fib(_ n: Int) -> Int {
        guard n > 0 else { return 0 }
        func _fib(_ n: Int, _ pre: Int = 1, _ cur: Int = 1) -> Int {
            if n <= 2 {
                return cur
            }
            return _fib(n-1, cur, pre + cur)
        }
        return _fib(n)
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=326 lang=swift
 *
 * [326] Power of Three
 */

// @lc code=start
extension Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        guard n > 0 else { return false }
        // calculated by python:
        // list(map(lambda x: 3 ** x, list(range(0,20))))
        // 3^20 = 3486784401 > 2147483647 = 2^31 - 1
        let p = [1, 3, 9, 27, 81, 243, 729, 2187, 6561, 19683, 59049, 177147, 531441, 1594323, 4782969, 14348907, 43046721, 129140163, 387420489, 1162261467]
        return p.contains(n)
    }
}
// @lc code=end


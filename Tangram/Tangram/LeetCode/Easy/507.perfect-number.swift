/*
 * @lc app=leetcode id=507 lang=swift
 *
 * [507] Perfect Number
 */

// @lc code=start
extension Solution {
    // [6, 28, 496, 8128, 33550336] only these are perfect!
    func checkPerfectNumber(_ num: Int) -> Bool {
        guard num > 5 else { return false }
        var count = 1
        let sentry = Int(floor(sqrt(Double(num))))
        for i in 2...sentry {
            if num % i == 0 {
                count += i + num / i
            }
            guard count <= num else { return false }
        }
        return count == num
    }
}
// @lc code=end


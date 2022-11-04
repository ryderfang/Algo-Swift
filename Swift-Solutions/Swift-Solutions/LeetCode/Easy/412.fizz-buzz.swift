/*
 * @lc app=leetcode id=412 lang=swift
 *
 * [412] Fizz Buzz
 */

// @lc code=start
extension Solution {
    func fizzBuzz(_ n: Int) -> [String] {
        return (1...n).map { x in
            if x % 15 == 0 {
                return "FizzBuzz"
            } else if x % 3 == 0 {
                return "Fizz"
            } else if x % 5 == 0 {
                return "Buzz"
            } else {
                return String(x)
            }
        }
    }
}
// @lc code=end


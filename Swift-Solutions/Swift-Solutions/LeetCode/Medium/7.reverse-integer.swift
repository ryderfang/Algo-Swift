/*
 * @lc app=leetcode id=7 lang=swift
 *
 * [7] Reverse Integer
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // [-2147483648, 2147483647]
    func reverse(_ x: Int) -> Int {
        func _toDigits(_ x: Int) -> [Int] {
            var ans = [Int]()
            var n = x
            while n > 0 {
                ans.append(n % 10)
                n /= 10
            }
            return ans
        }

        func _reverse(_ d: [Int], _ negative: Bool) -> Int {
            var ans = 0
            var factor = 1
            for x in d.reversed() {
                ans += factor * x
                factor *= 10
            }
            return negative ? -ans : ans
        }
        guard x != 0 else { return 0 }
        if x == -2147483648 {
            return 0
        }
        // x > -2147483648
        var n = x
        let negative = x < 0
        if negative {
            n = -x
        }

        let digits = _toDigits(n)
        var limit = Array(_toDigits(2147483647).reversed())
        if negative {
            limit[9] += 1
        }
        if n > 1000000000 {
            var check = true
            for i in 0...9 {
                if digits[i] < limit[i] {
                    break
                } else if digits[i] > limit[i] {
                    check = false
                    break
                }
            }
            if !check {
                return 0
            }
        }
        return _reverse(digits, negative)
    }
}
// @lc code=end


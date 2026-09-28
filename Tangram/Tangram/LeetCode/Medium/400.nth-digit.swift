/*
 * @lc app=leetcode id=400 lang=swift
 *
 * [400] Nth Digit
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findNthDigit(_ n: Int) -> Int {
        // (10^n - 1) - (10^(n-1) - 1)
        // 10^9 < 2147483647 < 10^10
        var ten = 10, last = 0
        let maxDigit = 9
        var digits = [Int](repeating: 0, count: maxDigit)
        for i in 1..<maxDigit {
            digits[i] = (ten - 1 - last) * i
            last = ten - 1
            ten = 10 * ten
        }
        var least = n
        var i = 1
        while i < maxDigit {
            if least > digits[i] {
                least -= digits[i]
            } else {
                break
            }
            i += 1
        }
        if least == 0 {
            return 9
        }
        least -= 1
        let index = least / i
        let num = String(Int(pow(Double(10), Double(i-1))) + index)
        let ans = Array(num)[least % i]
        return Int(String(ans))!
    }
}
// @lc code=end


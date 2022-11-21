/*
 * @lc app=leetcode id=29 lang=swift
 *
 * [29] Divide Two Integers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 不能使用 * / %
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        guard dividend != 0 else { return 0 }
        // 2^31 - 1
        let intMax = Int(Int32.max)
        // -2^31
        let intMin = Int(Int32.min)
        // -2^31/-1 is the only chance to overflow
        if dividend == intMin && divisor == -1 {
            return intMax
        }
        // else result is in [intMin, intMax]
        var positive = true
        if (dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0) {
            positive = false
        }
        var a = abs(dividend)
        let b = abs(divisor > 0 ? divisor : -divisor)
        if a < b {
            return 0
        } else if a == b {
            return positive ? 1 : -1
        }

        // a > b
        var quotient = 0
        // convert dividend to binary, high to low
        var abits = [Int]()
        while a != 0 {
            abits = [a & 1] + abits
            a >>= 1
        }
        var remainder = 0
        for bit in abits {
            let cur = (remainder << 1) + bit
            quotient <<= 1
            if cur < b {
                remainder = cur
            } else {
                quotient += 1
                remainder = cur - b
            }
        }

        print(remainder)
        return positive ? quotient : -quotient
    }
}
// @lc code=end

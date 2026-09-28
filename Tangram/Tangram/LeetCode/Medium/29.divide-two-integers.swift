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
        let intMax = Int(Int32.max)
        let intMin = Int(Int32.min)
        // -2^31/-1 is the only chance to overflow
        if dividend == intMin && divisor == -1 {
            return intMax
        }
        var remainder = abs(dividend)
        let down = abs(divisor)
        var quotient = 0
        for x in stride(from: 31, through: 0, by: -1) {
            if remainder >= (down << x) {
                quotient += (1 << x)
                remainder -= (down << x)
            }
        }
        if (dividend > 0) != (divisor > 0) {
            quotient = -quotient
        }
        print(remainder)
        return quotient
    }

    func _divide(_ dividend: Int, _ divisor: Int) -> Int {
        guard dividend != 0 else { return 0 }
        // 2^31 - 1
        let intMax = Int(Int32.max)
        // -2^31
        let intMin = Int(Int32.min)
        // -2^31/-1 is the only chance to overflow
        if dividend == intMin && divisor == -1 {
            return intMax
        }
        var a = abs(dividend)
        let b = abs(divisor)
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
        if (dividend > 0) != (divisor > 0) {
            quotient = -quotient
        }
        return quotient
    }
}
// @lc code=end

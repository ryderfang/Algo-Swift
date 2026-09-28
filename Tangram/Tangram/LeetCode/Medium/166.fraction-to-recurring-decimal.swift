/*
 * @lc app=leetcode id=166 lang=swift
 *
 * [166] Fraction to Recurring Decimal
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // (420,226) = 1.(8584070796460176991150442477876106194690265486725663716814159292035398230088495575221238938053097345132743362831)
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        print(Double(numerator) / Double(denominator))
        var remainder = [Int]()
        var quotient = [Int]()
        var start = -1
        let negative = (numerator > 0) != (denominator > 0)
        var (a, b) = (abs(numerator), abs(denominator))
        while a != 0 && quotient.count < 10000 {
            if let idx = remainder.firstIndex(where: { $0 == a }), idx > 0 {
                start = idx
                break
            }
            remainder.append(a)
            if a < b {
                a *= 10
                quotient.append(0)
            } else {
                quotient.append(a / b)
                a = (a % b) * 10
            }
        }
        guard quotient.count > 0 else { return "0" }
        var ans = ""
        if negative {
            ans.append("-")
        }
        ans.append("\(quotient[0])")
        guard quotient.count > 1 else { return ans }
        ans.append(".")
        if start > 0 {
            ans.append(quotient[1..<start].map { String($0) }.joined())
            ans.append("(")
            ans.append(quotient[start...].map { String($0) }.joined())
            ans.append(")")
        } else {
            ans.append(quotient[1...].map { String($0) }.joined())
        }
        return ans
    }
}

// @lc code=end

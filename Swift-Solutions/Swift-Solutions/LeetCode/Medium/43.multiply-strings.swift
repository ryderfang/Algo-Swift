/*
 * @lc app=leetcode id=43 lang=swift
 *
 * [43] Multiply Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 大数乘法
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        var a: [Int] = num1.reversed().map { Int(String($0))! }
        var b: [Int] = num2.reversed().map { Int(String($0))! }
        if a.count < b.count {
            swap(&a, &b)
        }
        var ans = [Int](repeating: 0, count: a.count + b.count)
        for j in 0..<b.count {
            // b[j] * a
            // fill 0's for shift j pos
            var tmp = [Int](repeating: 0, count: j)
            var carry = 0
            for i in 0..<a.count {
                let p = b[j] * a[i] + carry
                tmp.append(p % 10)
                carry = p / 10
            }
            tmp.append(carry)
            tmp += [Int](repeating: 0, count: ans.count - tmp.count)
            // ans += tmp
            carry = 0
            for i in 0..<ans.count {
                let sum = ans[i] + tmp[i] + carry
                ans[i] = sum % 10
                carry = sum / 10
            }
        }
        ans = [Int](ans.reversed())
        if let firstNoZero = ans.firstIndex(where: { $0 > 0 }) {
            ans = [Int](ans[firstNoZero...])
            return ans.map { String($0) }.joined()
        } else {
            return "0"
        }
    }
}
// @lc code=end


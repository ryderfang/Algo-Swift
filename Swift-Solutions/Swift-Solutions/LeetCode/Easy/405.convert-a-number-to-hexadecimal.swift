/*
 * @lc app=leetcode id=405 lang=swift
 *
 * [405] Convert a Number to Hexadecimal
 */

// @lc code=start
class Solution {
    func toBinaryStr(_ num: Int) -> String {
        toBinary(num).map { String($0) }.joined()
    }

    func toBinary(_ num: Int) -> [Int] {
        guard num != 0 else { return [0] }
        let isNagative = num < 0
        var n = abs(num)
        var ans = [Int]()
        while n > 0 {
            ans.append(isNagative ? 1 - n % 2 : n % 2)
            n >>= 1
        }
        if !isNagative {
            return ans.reversed()
        }
        // 补码 (two’s complement): -num = ~num + 1
        ans.append(contentsOf: [Int](repeating: 1, count: 32 - ans.count))
        var carry = (ans[0] + 1) / 2
        ans[0] = (ans[0] + 1) % 2
        for i in 1..<ans.count {
            if carry == 0 {
                break
            }
            let sum = ans[i] + carry
            ans[i] = sum % 2
            carry = sum / 2
        }
        return ans.reversed()
    }

    func binaryToHex(_ bits: [Int], uppercase: Bool = false) -> String {
        var bits: [Int] = bits.reversed()
        // 补齐
        if bits.count % 4 != 0 {
            let count = (bits.count / 4 + 1) * 4 - bits.count
            bits.append(contentsOf: [Int](repeating: 0, count: count))
        }
        var ans = [String]()
        for i in stride(from: 0, to: bits.count, by: 4) {
            let sum = UInt32(bits[i] + bits[i+1] * 2 + bits[i+2] * 4 + bits[i+3] * 8)
            if sum < 10 {
                ans.append(String(sum))
            } else {
                let ascii: UInt32 = (uppercase ? UnicodeScalar("A") : UnicodeScalar("a")).value + sum - 10
                ans.append(String(UnicodeScalar(ascii)!))
            }
        }
        return ans.reversed().joined()
    }

    func toHex1(_ num: Int) -> String {
        return binaryToHex(toBinary(num))
    }
}
// @lc code=end


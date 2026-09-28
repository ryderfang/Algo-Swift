/*
 * @lc app=leetcode id=67 lang=swift
 *
 * [67] Add Binary
 */

// @lc code=start
extension Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        var ra: [Character] = a.reversed()
        var rb: [Character] = b.reversed()
        let sz = max(ra.count, rb.count)
        for _ in ra.count..<sz {
            ra.append("0")
        }
        for _ in rb.count..<sz {
            rb.append("0")
        }
        var ans: [Character] = [Character](repeating: "0", count: sz)
        var carry = 0
        for i in 0..<sz {
            let sum = Int(String(ra[i]))! + Int(String(rb[i]))! + carry
            ans[i] = Character(UnicodeScalar(sum % 2 + 48)!)
            carry = sum / 2
        }
        if carry > 0 {
            ans.append("1")
        }
        return String(ans.reversed())
    }
}
// @lc code=end


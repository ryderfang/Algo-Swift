/*
 * @lc app=leetcode id=171 lang=swift
 *
 * [171] Excel Sheet Column Number
 */

// @lc code=start
extension Solution {
    // one-line solution
    func titleToNumber(_ columnTitle: String) -> Int {
        return columnTitle.unicodeScalars.reduce(0, { $0 * 26 + Int($1.value) - 64})
    }

    func titleToNumber1(_ columnTitle: String) -> Int {
        var scale = 1
        var ans = 0
        for ch in columnTitle.reversed() {
            let str = String(ch)
            ans += scale * (Int(UnicodeScalar(str)!.value - UnicodeScalar("A").value) + 1)
            scale *= 26
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=168 lang=swift
 *
 * [168] Excel Sheet Column Title
 */

// @lc code=start
extension Solution {
    func convertToTitle(_ columnNumber: Int) -> String {
        let sheet = (UnicodeScalar("A").value...UnicodeScalar("Z").value).map { String(UnicodeScalar($0)!) }
        var n = columnNumber
        var ans: [String] = []
        while n > 0 {
            var x = n % 26
            if x == 0 {
                x = 26
            }
            ans.append(sheet[x - 1])
            n = (n - x) / 26
        }
        return Array(ans.reversed()).joined()
    }
}
// @lc code=end


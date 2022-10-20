/*
 * @lc app=leetcode id=12 lang=swift
 *
 * [12] Integer to Roman
 */

// @lc code=start
extension Solution {
    private func symbolOfValue(_ v: Int) -> String? {
        guard v > 0 else { return "" }
        return [900: "CM", 800: "DCCC", 700: "DCC", 600: "DC", 500: "D",
                 400: "CD", 300: "CCC", 200: "CC", 100: "C",
                 90: "XC", 80: "LXXX", 70: "LXX", 60:"LX", 50:"L",
                 40: "XL", 30: "XXX", 20: "XX", 10: "X",
                 9: "IX", 8: "VIII", 7: "VII", 6: "VI", 5: "V",
                 4: "IV", 3: "III", 2: "II", 1: "I"][v]
    }

    func intToRoman(_ num: Int) -> String {
        var ans = ""
        var tmp = num
        if tmp >= 1000 {
            ans.append(String([Character](repeating: "M", count: num / 1000)))
            tmp %= 1000
        }
        ans.append(symbolOfValue(tmp / 100 * 100)!)
        tmp %= 100
        ans.append(symbolOfValue(tmp / 10 * 10)!)
        tmp %= 10
        ans.append(symbolOfValue(tmp)!)
        return ans
    }
}
// @lc code=end


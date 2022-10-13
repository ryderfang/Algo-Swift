/*
 * @lc app=leetcode id=13 lang=swift
 *
 * [13] Roman to Integer
 */

// @lc code=start
fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

class Solution {
    func romanToInt(_ s: String) -> Int {
        var res = 0
        var i = 0
        let sz = s.count
        while i < sz{
            let ch: Character = s[i]
            var nextCh: Character? = nil
            if i < sz - 1 {
                nextCh = s[i+1]
            }
            switch ch {
            case "M":
                res += 1000
            case "D":
                res += 500
            case "C":
                if nextCh == "D" {
                    res += 400
                    i += 1
                } else if nextCh == "M" {
                    res += 900
                    i += 1
                } else {
                    res += 100
                }
            case "L":
                res += 50
            case "X":
                if nextCh == "L" {
                    res += 40
                    i += 1
                } else if nextCh == "C" {
                    res += 90
                    i += 1
                } else {
                    res += 10
                }
            case "V":
                res += 5
            case "I":
                if nextCh == "V" {
                    res += 4
                    i += 1
                } else if nextCh == "X" {
                    res += 9
                    i += 1
                } else {
                    res += 1
                }
            default:
                break
            }
            i += 1
        }
        return res
    }
}
// @lc code=end


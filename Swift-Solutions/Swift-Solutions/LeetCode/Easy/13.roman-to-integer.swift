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

fileprivate extension Character {
    func digit() -> Int {
        switch self {
        case "M":
            return 1000
        case "D":
            return 500
        case "C":
            return 100
        case "L":
            return 50
        case "X":
            return 10
        case "V":
            return 5
        case "I":
            return 1
        default:
            return -1
        }
    }
}

class Solution {
    func romanToInt(_ s: String) -> Int {
        var res = 0
        let n = s.count
        for i in 0..<n {
            let d = s[i].digit()
            if i < n - 1 && s[i+1].digit() > d {
                res -= d
            } else {
                res += d
            }
        }
        return res
    }
}
// @lc code=end


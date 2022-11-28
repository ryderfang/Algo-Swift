/*
 * @lc app=leetcode id=91 lang=swift
 *
 * [91] Decode Ways
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numDecodings(_ s: String) -> Int {
        let n = s.count
        guard n > 0 else { return 0 }
        var mp = [String: String]()
        for i in 1...26 {
            mp[String(i)] = String(UnicodeScalar(65 + i - 1)!)
        }
        var c0 = 0
        if let _ = mp[s[0]] {
            c0 = 1
        }
        guard n > 1 else { return c0 }
        var c1 = 0
        if let _ = mp[s[1]] {
            c1 += c0
        }
        if let _ = mp[s[0...1]] {
            c1 += 1
        }
        for i in 2..<n {
            var next_c1 = 0
            if let _ = mp[s[i]] {
                next_c1 += c1
            }

            if let _ = mp[s[i-1...i]] {
                next_c1 += c0
            }
            (c0, c1) = (c1, next_c1)
        }
        return c1
    }
}


fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }
}

// @lc code=end


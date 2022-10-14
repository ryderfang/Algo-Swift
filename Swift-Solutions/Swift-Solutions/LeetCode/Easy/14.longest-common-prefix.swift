/*
 * @lc app=leetcode id=14 lang=swift
 *
 * [14] Longest Common Prefix
 */

// @lc code=start
fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        var ret = ""
        var i = 0
        while true {
            var ch: Character? = nil
            var match = true
            for s in strs {
                if i < s.count {
                    if ch == nil {
                        ch = s[i]
                    } else if ch != s[i] {
                        match = false
                        break
                    }
                } else {
                    match = false
                    break
                }
            }
            if match {
                ret.append(ch!)
            } else {
                break
            }
            i += 1
        }
        return ret
    }
}
// @lc code=end


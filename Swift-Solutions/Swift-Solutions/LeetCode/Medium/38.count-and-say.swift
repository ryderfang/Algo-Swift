/*
 * @lc app=leetcode id=38 lang=swift
 *
 * [38] Count and Say
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countAndSay(_ n: Int) -> String {
        guard n > 1 else { return "1" }
        func _say(it str: String) -> String {
            let chars: [Character] = Array(str)
            let n = chars.count
            guard n > 1 else { return "1" + str }
            var count = 1
            var ans = ""
            for i in 0..<n {
                if i == 0 {
                    continue
                }
                if chars[i] == chars[i-1] {
                    count += 1
                } else {
                    ans += "\(count)" + String(chars[i-1])
                    count = 1
                }
            }
            ans += "\(count)" + String(chars[n-1])
            return ans
        }
        var str = "1"
        for _ in 1..<n {
            str = _say(it: str)
        }
        return str
    }
}
// @lc code=end


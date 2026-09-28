/*
 * @lc app=leetcode id=8 lang=swift
 *
 * [8] String to Integer (atoi)
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func myAtoi(_ s: String) -> Int {
        let chs = Array(s)
        let len = chs.count
        guard len > 0 else { return 0 }
        var i = 0
        // ignore leading whitespace
        while i < len && chs[i] == " " {
            i += 1
        }
        if i >= len {
            return 0
        }
        var positive = true
        if chs[i] == "-" {
            positive = false
            i += 1
        } else if chs[i] == "+" {
            i += 1
        }

        var ans = 0
        while i < len && ("0"..."9").contains(chs[i]) {
            let num = Int(String(chs[i]))!
            ans = ans * 10
            ans += num
            i += 1
            if ans > Int32.max {
                break
            }
        }
        if positive {
            return min(ans, Int(Int32.max))
        } else {
            return max(-ans, Int(Int32.min))
        }
    }
}
// @lc code=end


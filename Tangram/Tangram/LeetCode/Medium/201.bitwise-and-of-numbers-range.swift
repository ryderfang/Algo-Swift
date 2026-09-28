/*
 * @lc app=leetcode id=201 lang=swift
 *
 * [201] Bitwise AND of Numbers Range
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
        // left:  xxx1xxx
        // right: yyy1yyy
        // ->     xx10000
        // ->     x100000
        var ans = 0
        for i in 0..<32 {
            guard ((left >> i) & 1 > 0) && ((right >> i) & 1 > 0) else {
                continue
            }
            if i == 31 {
                ans += (1 << i)
                continue
            }
            // 第 i 位都是 1，判断是否存在 0 的可能性
            var ck = false
            // 将 [i+1..<32] 位依次变成 1 检查
            for j in i+1..<32 {
                let tmp = ((left >> j) | 1) << j
                if tmp >= left && tmp <= right {
                    ck = true
                    break
                }
                if tmp > right {
                    break
                }
            }
            if !ck {
                ans += (1 << i)
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=338 lang=swift
 *
 * [338] Counting Bits
 */

// @lc code=start
extension Solution {
    // 可以优化为递推
    // ans[i] = ans[i>>1] + ans[i%2]
    func countBits(_ n: Int) -> [Int] {
        guard n > 0 else { return [0] }
        let handler: (Int) -> Int = {
            var ret = 0
            var n = $0
            while n > 0 {
                ret += 1
                n = n & (n - 1)
            }
            return ret
        }
        var ans = [0]
        for i in 1...n {
            ans.append(handler(i))
        }
        return ans
    }
}
// @lc code=end


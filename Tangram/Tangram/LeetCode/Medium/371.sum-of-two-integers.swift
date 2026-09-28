/*
 * @lc app=leetcode id=371 lang=swift
 *
 * [371] Sum of Two Integers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // a.advanced(by: b) -> aha??
    func getSum(_ a: Int, _ b: Int) -> Int {
        var ma: Int32 = Int32(a)
        var mb: Int32 = Int32(b)
        var carry = 0
        var ans: Int32 = 0
        var fact: Int32 = 1
        for _ in 0..<32 {
            if carry == 0 {
                switch (ma & 1, mb & 1) {
                    case (0, 0):
                        break
                    case (0, 1), (1, 0):
                        ans |= fact
                    case (1, 1):
                        carry = 1
                    default:
                        break
                }
            } else {
                switch (ma & 1, mb & 1) {
                    case (0, 0):
                        ans |= fact
                        carry = 0
                    case (0, 1), (1, 0):
                        carry = 1
                    case (1, 1):
                        ans |= fact
                        carry = 1
                    default:
                        break
                }
            }
            ma >>= 1
            mb >>= 1
            fact <<= 1
        }
        return Int(ans)
    }
}
// @lc code=end

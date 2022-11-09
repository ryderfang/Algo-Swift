/*
 * @lc app=leetcode id=461 lang=swift
 *
 * [461] Hamming Distance
 */

// @lc code=start
extension Solution {
    // number of '1's of 'x xor y'
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        let xor = x ^ y
        var ans = 0
        var n = xor
        while n > 0 {
            n &= (n - 1)
            ans += 1
        }
        return ans
    }
}
// @lc code=end


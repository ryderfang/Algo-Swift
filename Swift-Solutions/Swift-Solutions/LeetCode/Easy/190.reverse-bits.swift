/*
 * @lc app=leetcode id=190 lang=swift
 *
 * [190] Reverse Bits
 */

// @lc code=start
extension Solution {
    func reverseBits(_ n: Int) -> Int {
        var str = String(n, radix: 2)
        str.insert(contentsOf: [Character](repeating: "0", count: 32 - str.count), at: str.startIndex)
        return strtol(String(str.reversed()), nil, 2)
    }
}
// @lc code=end


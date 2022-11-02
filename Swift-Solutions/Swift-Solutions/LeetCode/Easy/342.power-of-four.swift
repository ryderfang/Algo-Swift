/*
 * @lc app=leetcode id=342 lang=swift
 *
 * [342] Power of Four
 */

// @lc code=start
class Solution {
    // 4^n = 3 * (4^n-1 + 4^n-2 + ... + 4 + 1)
    func isPowerOfFour(_ n: Int) -> Bool {
        return n > 0 && (n & (n - 1) == 0) && (n - 1) % 3 == 0
    }

    func isPowerOfFour1(_ n: Int) -> Bool {
        guard n > 0 else { return false }
        // calculated by python:
        // list(map(lambda x: 4 ** x, list(range(0,16))))
        // 4^16 = 4294967296 > 2147483647 = 2^31 - 1
        let p = [1, 4, 16, 64, 256, 1024, 4096, 16384, 65536, 262144, 1048576, 4194304, 16777216, 67108864, 268435456, 1073741824, 4294967296]
        return p.contains(n)
    }
}
// @lc code=end


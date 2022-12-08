/*
 * @lc app=leetcode id=137 lang=swift
 *
 * [137] Single Number II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var (b1, b0) = (0, 0)
        for num in nums {
            b0 = (b0 ^ num) & (~b1)
            b1 = (b1 ^ num) & (~b0)
        }
        return b0
    }

    func singleNumber2(_ nums: [Int]) -> Int {
        var ans = 0
        for i in 0..<32 {
            let mask = 1 << i
            // count of 1 at position i
            var count = 0
            for num in nums {
                if num & mask > 0 {
                    count += 1
                }
            }
            if count % 3 == 1 {
                ans |= mask
            }
        }
        // nagative number
        if ans & (1 << 31) > 0 {
            ans -= (1 << 32)
        }
        return Int(ans)
    }
}
// @lc code=end


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
    // why?
    // [1] + (3) + (3) + ... + (3)
    func singleNumber2(_ nums: [Int]) -> Int {
        var (ones, twos) = (0, 0)
        for num in nums {
            ones = (ones ^ num) & (~twos)
            twos = (twos ^ num) & (~ones)
        }
        return ones
    }

    func singleNumber2_1(_ nums: [Int]) -> Int {
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


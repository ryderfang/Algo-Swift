/*
 * @lc app=leetcode id=260 lang=swift
 *
 * [260] Single Number III
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        var mp = [Int: Int]()
        for x in nums {
            mp[x, default: 0] += 1
        }
        var ans = [Int]()
        for (k, v) in mp {
            if v == 1 {
                ans.append(k)
            }
        }
        return ans
    }

    func singleNumber3(_ nums: [Int]) -> [Int] {
        // `xorResult` contains the bit 1s (so called set bits) at where the two result numbers differ
        let xorResult = nums.reduce(0, ^)

        // the right most set bit
        let rightMostSetBit = xorResult & -xorResult

        /* All the numbers can be divided into two groups:
        * the 1st group consisting of all numbers whose bits at "rightMostSetBit" is 0,
        * the 2nd group consisting of all numbers whose bits at "rightMostSetBit" is 1.
        */
        var result = [0, 0]
        for num in nums {
            if num & rightMostSetBit == 0 {
                result[0] ^= num
            } else {
                result[1] ^= num
            }
        }

        return result
    }
}
// @lc code=end


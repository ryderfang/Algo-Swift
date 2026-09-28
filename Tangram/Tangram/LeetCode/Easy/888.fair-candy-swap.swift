/*
 * @lc app=leetcode id=888 lang=swift
 *
 * [888] Fair Candy Swap
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func fairCandySwap(_ aliceSizes: [Int], _ bobSizes: [Int]) -> [Int] {
        let sum1 = aliceSizes.reduce(0, +)
        let sum2 = bobSizes.reduce(0, +)
        let set1 = Set(aliceSizes)
        let set2 = Set(bobSizes)
        let diff = (sum1 - sum2) / 2
        for a in set1 {
            if set2.contains(a - diff) {
                return [a, a - diff]
            }
        }
        return [-1, -1]
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=605 lang=swift
 *
 * [605] Can Place Flowers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        let fixed = [1, 0] + flowerbed + [0, 1]
        var count = 0, ans = 0
        for x in fixed {
            if x == 1 {
                ans += (count - 1) / 2
                count = 0
            } else {
                count += 1
            }
        }
        return ans >= n
    }
}
// @lc code=end


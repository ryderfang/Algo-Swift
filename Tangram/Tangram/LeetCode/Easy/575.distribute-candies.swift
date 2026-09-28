/*
 * @lc app=leetcode id=575 lang=swift
 *
 * [575] Distribute Candies
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func distributeCandies(_ candyType: [Int]) -> Int {
        var mp = [Int: Int]()
        for x in candyType {
            mp[x, default: 0] += 1
        }
        return min(candyType.count / 2, mp.keys.count)
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=771 lang=swift
 *
 * [771] Jewels and Stones
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
        let jewels: Set<Character> = Set(jewels)
        var count = 0
        for ch in stones {
            if jewels.contains(ch) {
                count += 1
            }
        }
        return count
    }
}
// @lc code=end


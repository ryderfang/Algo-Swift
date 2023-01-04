/*
 * @lc app=leetcode id=908 lang=swift
 *
 * [908] Smallest Range I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func smallestRangeI(_ nums: [Int], _ k: Int) -> Int {
        // [min-k, min+k] ~ [max-k, max+k]
        // max - k <= min + k -> 0
        let n = nums.count
        guard n > 1 else { return 0 }
        var (a, b) = (nums.min()!, nums.max()!)
        return max(b - a - 2 * k, 0)
    }
}
// @lc code=end


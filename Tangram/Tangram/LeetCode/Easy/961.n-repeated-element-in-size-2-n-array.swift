/*
 * @lc app=leetcode id=961 lang=swift
 *
 * [961] N-Repeated Element in Size 2N Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func repeatedNTimes(_ nums: [Int]) -> Int {
        var mp = [Int: Int]()
        for n in nums {
            mp[n, default: 0] += 1
            if let x = mp[n], x > 1 {
                return n
            }
        }
        return -1
    }
}
// @lc code=end


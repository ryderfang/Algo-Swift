/*
 * @lc app=leetcode id=275 lang=swift
 *
 * [275] H-Index II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // citations - already ascending sorted
    // - O(logN)
    func hIndex(_ citations: [Int]) -> Int {
        let n = citations.count
        var (left, right) = (0, n - 1)
        while left < right {
            let mid = left + (right - left) / 2
            if citations[mid] >= n - mid {
                right = mid
            } else {
                left = mid + 1
            }
        }
        if citations[right] >= n - right {
            return n - right
        } else {
            return 0
        }
    }
}
// @lc code=end


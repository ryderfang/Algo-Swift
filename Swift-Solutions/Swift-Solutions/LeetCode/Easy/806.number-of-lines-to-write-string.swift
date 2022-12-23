/*
 * @lc app=leetcode id=806 lang=swift
 *
 * [806] Number of Lines To Write String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numberOfLines(_ widths: [Int], _ s: String) -> [Int] {
        var (lines, count) = (1, 0)
        for ch in s {
            let tmp = count + widths[Int(ch.asciiValue! - 97)]
            if tmp <= 100 {
                count = tmp
            } else {
                lines += 1
                count = tmp - count
            }
        }
        return [lines, count]
    }
}
// @lc code=end


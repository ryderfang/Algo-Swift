/*
 * @lc app=leetcode id=56 lang=swift
 *
 * [56] Merge Intervals
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        let n = intervals.count
        guard n > 1 else { return intervals }
        let intervals = intervals.sorted(by: {
            $0[0] < $1[0]
        })
        var ans = [[Int]]()
        var (start, end) = (intervals[0][0], intervals[0][1])
        for sec in intervals.dropFirst() {
            if sec[0] > end {
                ans.append([start, end])
                start = sec[0]
                end = sec[1]
                continue
            }
            start = min(start, sec[0])
            end = max(end, sec[1])
        }
        ans.append([start, end])
        return ans
    }
}
// @lc code=end


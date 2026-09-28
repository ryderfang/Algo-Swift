/*
 * @lc app=leetcode id=57 lang=swift
 *
 * [57] Insert Interval
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        let n = intervals.count
        guard n > 0 else { return [newInterval] }
        var i = 0, j = 0
        let (start, end) = (newInterval[0], newInterval[1])
        var k = 0
        while k < n {
            if intervals[k][1] >= start {
                i = k
                break
            }
            k += 1
        }
        var ans = intervals
        if k == n {
            ans.append(newInterval)
            return ans
        }
        while k < n {
            if intervals[k][0] > end {
                j = k
                break
            }
            if intervals[k][1] >= end {
                j = k + 1
                break
            }
            k += 1
        }
        if k == n {
            j = n
        }
        if i == j {
            ans.insert(newInterval, at: i)
        } else {
            let (newStart, newEnd) = (min(start, intervals[i][0]), max(end, intervals[j-1][1]))
            ans.removeSubrange(i..<j)
            ans.insert([newStart, newEnd], at: i)
        }
        return ans
    }
}
// @lc code=end


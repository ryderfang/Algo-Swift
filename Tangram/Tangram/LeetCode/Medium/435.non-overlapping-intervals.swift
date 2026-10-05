/*
 * @lc app=leetcode id=435 lang=swift
 *
 * [435] Non-overlapping Intervals
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        var minSt = Int.max, maxEnd = 0
        for ele in intervals {
            minSt = min(ele[0], minSt)
            maxEnd = max(ele[1], maxEnd)
        }
        let offset = max(-minSt, 0)
        maxEnd += offset
        let sorted = intervals.sorted { a, b in
            return a[1] < b[1]
        }.map { ele in
            [ele[0] + offset, ele[1] + offset]
        }
        
        let n = sorted.count
        // max count to current [i]
        var dp = Array(repeating: 0, count: maxEnd + 1)
        var curEnd = 0
        for i in 0..<n {
            let (st, ed) = (sorted[i][0], sorted[i][1])
            if curEnd < ed {
                for j in curEnd...ed-1 {
                    dp[j] = max(dp[j], dp[curEnd])
                }
            }
            // [0..curEnd] ~ [st, end]
            if st > curEnd {
                dp[ed] = max(dp[ed], dp[curEnd] + 1)
            } else {
                // 0..st..curEnd..ed
                // 0..[st..ed]..curEnd
                dp[ed] = max(dp[ed], dp[curEnd], dp[st] + 1)
            }
            curEnd = max(curEnd, ed)
        }
        return n - (dp.max() ?? 0)
    }
}
// @lc code=end

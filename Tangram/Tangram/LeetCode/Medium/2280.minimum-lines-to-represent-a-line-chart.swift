/*
 * @lc app=leetcode id=2280 lang=swift
 *
 * [2280] Minimum Lines to Represent a Line Chart
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minimumLines(_ stockPrices: [[Int]]) -> Int {
        func _dotsInLine(_ p1: [Int], _ p2: [Int], _ p0: [Int]) -> Bool {
            (p1[0] - p0[0]) * (p2[1] - p0[1]) - (p2[0] - p0[0]) * (p1[1] - p0[1]) == 0
        }
        let n = stockPrices.count
        if n == 1 { return 0 }
        if n == 2 { return 1 }
        let stockPrices = stockPrices.sorted(by: { $0[0] < $1[0] })
        var p0 = stockPrices[0], p1 = stockPrices[1]
        var ans = 1
        for i in 2..<n {
            let p2 = stockPrices[i]
            if !_dotsInLine(p2, p1, p0) {
                ans += 1
            }
            p0 = p1
            p1 = p2
        }
        return ans
    }
}
// @lc code=end


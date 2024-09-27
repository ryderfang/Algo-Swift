/*
 * @lc app=leetcode id=1578 lang=swift
 *
 * [1578] Minimum Time to Make Rope Colorful
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minCost(_ colors: String, _ neededTime: [Int]) -> Int {
        let colors = Array(colors)
        let n = colors.count
        guard n > 1 else { return 0 }
        var cur = colors[0]
        var tmpCost: [Int] = [neededTime[0]]
        var ans = 0
        for i in 1..<n {
            if colors[i] == cur {
                tmpCost.append(neededTime[i])
            } else {
                tmpCost.sort()
                tmpCost.removeLast()
                ans += tmpCost.reduce(0, +)
                
                cur = colors[i]
                tmpCost = [neededTime[i]]
            }
        }
        tmpCost.sort()
        tmpCost.removeLast()
        ans += tmpCost.reduce(0, +)
        return ans
    }
}

// @lc code=end


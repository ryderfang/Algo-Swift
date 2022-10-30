/*
 * @lc app=leetcode id=169 lang=swift
 *
 * [169] Majority Element
 */

// @lc code=start
class Solution {
    // 投票算法 (vote algorithm)
    func majorityElement(_ nums: [Int]) -> Int {
        var candidate = 0, vote = 0
        for x in nums {
            if vote == 0 {
                candidate = x
            }
            vote += (candidate == x) ? 1 : -1
        }
        return candidate
    }

    func majorityElement1(_ nums: [Int]) -> Int {
        var ans = [Int]()
        for x in nums {
            let top = ans.last
            if top != nil && top != x {
                ans.removeLast()
            } else {
                ans.append(x)
            }
        }
        return ans.last!
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=434 lang=swift
 *
 * [434] Number of Segments in a String
 */

// @lc code=start
class Solution {
    func countSegments(_ s: String) -> Int {
        var ans = 0
        var flag = false
        for ch in s {
            if ch != " " {
                flag = true
            } else {
                if flag {
                    ans += 1
                    flag = false
                }
            }
        }
        if flag {
            ans += 1
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=228 lang=swift
 *
 * [228] Summary Ranges
 */

// @lc code=start
class Solution {
    func summaryRanges(_ nums: [Int]) -> [String] {
        let n = nums.count
        guard n > 0 else { return [] }
        var low: Int? = nums[0], up: Int? = low
        var i = 1
        var ans = [String]()
        while i < n {
            while i < n && nums[i] == up! + 1 {
                up = nums[i]
                i += 1
            }
            up == low ? ans.append("\(up!)") : ans.append("\(low!)->\(up!)")
            if i >= n {
                low = nil
                up = nil
                break
            }
            low = nums[i]
            up = low
            i += 1
        }
        if let low = low, let up = up {
            up == low ? ans.append("\(up)") : ans.append("\(low)->\(up)")
        }
        return ans
    }
}
// @lc code=end


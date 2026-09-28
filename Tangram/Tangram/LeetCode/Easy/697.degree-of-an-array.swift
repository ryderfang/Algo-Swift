/*
 * @lc app=leetcode id=697 lang=swift
 *
 * [697] Degree of an Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findShortestSubArray(_ nums: [Int]) -> Int {
        var mp = [Int: (start: Int, end: Int, count: Int)]()
        let n = nums.count
        for i in 0..<n {
            if let item = mp[nums[i]] {
                mp[nums[i]] = (start: item.start, end: i, count: item.count + 1)
            } else {
                mp[nums[i]] = (start: i, end: i, count: 1)
            }
        }
        var degree = 0
        for x in mp.values {
            degree = max(degree, x.count)
        }
        var ans = Int.max
        for (_, v) in mp {
            if v.count == degree {
                ans = min(ans, v.end - v.start + 1)
            }
        }
        return ans
    }
}
// @lc code=end


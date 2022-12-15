/*
 * @lc app=leetcode id=594 lang=swift
 *
 * [594] Longest Harmonious Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findLHS(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return 0 }
        var mp = [Int: Int]()
        for i in 0..<n {
            mp[nums[i], default: 0] += 1
        }
        guard mp.keys.count > 1 else { return 0 }
        var ans = 0
        let keys = mp.keys.sorted()
        var pre = keys[0]
        for i in 1..<keys.count {
            if keys[i] - pre == 1 {
                ans = max(ans, mp[pre, default: 0] + mp[keys[i], default: 0])
            }
            pre = keys[i]
        }
        return ans
    }
}
// @lc code=end


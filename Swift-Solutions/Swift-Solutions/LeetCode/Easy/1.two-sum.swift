/*
 * @lc app=leetcode id=1 lang=swift
 *
 * [1] Two Sum
 */

// @lc code=start
extension Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var mp = [Int: Int]()
        for (i, x) in nums.enumerated() {
            if let last = mp[target - x] {
                return [last, i]
            }

            if mp[x] == nil {
                mp[x] = i
            }
        }
        return []
    }
}
// @lc code=end


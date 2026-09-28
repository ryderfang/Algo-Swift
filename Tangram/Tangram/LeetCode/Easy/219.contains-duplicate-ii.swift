/*
 * @lc app=leetcode id=219 lang=swift
 *
 * [219] Contains Duplicate II
 */

// @lc code=start
extension Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        let n = nums.count
        guard n > 1 else { return false }
        var mp = [Int: Int]()
        for (i, x) in nums.enumerated() {
            if let lastIdx = mp[x] {
                guard i - lastIdx > k else { return true }
            }
            mp[x] = i
        }
        return false
    }
}
// @lc code=end


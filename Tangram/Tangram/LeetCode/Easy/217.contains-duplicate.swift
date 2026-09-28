/*
 * @lc app=leetcode id=217 lang=swift
 *
 * [217] Contains Duplicate
 */

// @lc code=start
extension Solution {
    // Cheater: Set(nums).count != nums.count
    func containsDuplicate(_ nums: [Int]) -> Bool {
        let n = nums.count
        let a = nums.sorted()
        for i in 1..<n {
            if a[i]^a[i-1] == 0 {
                return true
            }
        }
        return false
    }
}
// @lc code=end


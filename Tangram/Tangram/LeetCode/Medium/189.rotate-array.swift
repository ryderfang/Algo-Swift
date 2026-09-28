/*
 * @lc app=leetcode id=189 lang=swift
 *
 * [189] Rotate Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // O(1) solution -> reverse(0, n) + reverse(0, k) + reverse(k, n)
    func rotate(_ nums: inout [Int], _ k: Int) {
        guard k > 0 else { return }
        let n = nums.count
        let step = k % n
        nums = Array(nums[n-step..<n] + nums[0..<n-step])
    }
}
// @lc code=end


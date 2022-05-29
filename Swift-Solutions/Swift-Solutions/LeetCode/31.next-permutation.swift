/*
 * @lc app=leetcode id=31 lang=swift
 *
 * [31] Next Permutation
 */

// @lc code=start
extension Solution {
    func nextPermutation(_ nums: inout [Int]) {
        let sz = nums.count
        if sz <= 1 {
            return
        }
        var i = sz - 2
        // 找到最后一个逆序数
        while i >= 0 && nums[i] >= nums[i+1] {
            i -= 1
        }
        if i < 0 {
            // sorted
            nums.reverse()
            return
        }
        var j = sz - 1
        while j >= i && nums[j] <= nums[i] {
            j -= 1
        }
        nums.swapAt(i, j)
        // reverse [i+1,sz)
        nums = Array(nums[0...i] + nums[i+1..<sz].reversed())
    }
}
// @lc code=end


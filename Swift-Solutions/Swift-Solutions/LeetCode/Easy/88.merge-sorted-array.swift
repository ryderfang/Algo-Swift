/*
 * @lc app=leetcode id=88 lang=swift
 *
 * [88] Merge Sorted Array
 */

// @lc code=start
class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = 0, j = 0
        while i < m + j && j < n {
            if nums2[j] <= nums1[i] {
                nums1.insert(nums2[j], at: i)
                j += 1
            }
            i += 1
        }
        nums1.insert(contentsOf: nums2[j..<n], at: i)
        nums1.removeLast(n)
    }
}
// @lc code=end


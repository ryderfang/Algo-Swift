/*
 * @lc app=leetcode id=349 lang=swift
 *
 * [349] Intersection of Two Arrays
 */

// @lc code=start
extension Solution {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        return [Int](Set(nums1).intersection(Set(nums2)))
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=350 lang=swift
 *
 * [350] Intersection of Two Arrays II
 */

// @lc code=start
extension Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let nums1 = nums1.sorted()
        let nums2 = nums2.sorted()
        var ans = [Int]()
        var i = 0, j = 0
        while i < nums1.count && j < nums2.count {
            if nums1[i] == nums2[j] {
                ans.append(nums1[i])
                i += 1
                j += 1
            } else if nums1[i] < nums2[j] {
                i += 1
            } else {
                j += 1
            }
        }
        return ans
    }
}
// @lc code=end


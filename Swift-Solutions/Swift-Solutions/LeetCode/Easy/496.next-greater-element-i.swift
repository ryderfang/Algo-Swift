/*
 * @lc app=leetcode id=496 lang=swift
 *
 * [496] Next Greater Element I
 */

// @lc code=start
extension Solution {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var ans = [Int]()
        for x in nums1 {
            var found = false
            var add = false
            for y in nums2 {
                if y == x {
                    found = true
                } else if y > x {
                    if found {
                        ans.append(y)
                        add = true
                        break
                    }
                }
            }
            if !add {
                ans.append(-1)
            }
        }
        return ans
    }
}
// @lc code=end


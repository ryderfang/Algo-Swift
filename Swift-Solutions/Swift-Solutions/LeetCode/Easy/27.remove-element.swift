/*
 * @lc app=leetcode id=27 lang=swift
 *
 * [27] Remove Element
 */

// @lc code=start
extension Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var sz = nums.count
        var i = 0
        while i < sz {
            if nums[i] == val {
                nums.remove(at: i)
                sz -= 1
            } else {
                i += 1
            }
        }
        return sz
    }
}
// @lc code=end


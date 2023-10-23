/*
 * @lc app=leetcode id=287 lang=swift
 *
 * [287] Find the Duplicate Number
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findDuplicate1(_ nums: [Int]) -> Int {
        var st = Set<Int>()
        var ans = -1
        for (_, v) in nums.enumerated() {
            if st.contains(v) {
                ans = v
                break
            }
            st.insert(v)
        }
        return ans
    }

    // 转换成 Cycle_detection 问题
    // 快慢指针
    func findDuplicate(_ nums: [Int]) -> Int {
        // get a index in loop
        var (slow, fast) = (nums[0], nums[0])
        repeat {
            slow = nums[slow]
            fast = nums[nums[fast]]
        } while slow != fast
        // get the loop entrance
        var (i, idx) = (nums[0], slow)
        while i != idx {
            i = nums[i]
            idx = nums[idx]
        }
        return i
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=334 lang=swift
 *
 * [334] Increasing Triplet Subsequence
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func increasingTriplet(_ nums: [Int]) -> Bool {
        let n = nums.count
        guard n >= 3 else { return false }
        var (x, y) = (nums[0], Int.max)
        for i in 1..<n {
            if nums[i] > nums[i-1] {
                y = min(nums[i], y)
                if nums[i] > y {
                    return true
                }
            } else {
                x = min(nums[i], x)
                if nums[i] > x {
                    y = min(nums[i], y)
                }
            }
        }
        return false
    }

    // Better solution
    func increasingTriplet2(_ nums: [Int]) -> Bool {
        guard nums.count >= 3 else { return false }
        var (small, mid) = (Int.max, Int.max)

        for n in nums {
            if n <= small {
                small = n
            } else if n <= mid {
                mid = n
            } else if n > mid {
                return true
            }
        }
        return false
    }
}
// @lc code=end


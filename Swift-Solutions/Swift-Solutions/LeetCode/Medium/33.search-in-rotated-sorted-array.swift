/*
 * @lc app=leetcode id=33 lang=swift
 *
 * [33] Search in Rotated Sorted Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    fileprivate func search(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        var l = 0, r = n - 1
        while l <= r {
            let m = l + (r - l) / 2
            if nums[m] == target {
                return m
            }
            let setL: () -> Void = {
                l = m + 1
            }
            let setR: () -> Void = {
                r = m - 1
            }
            if nums[m] >= nums[l] {
                if nums[l] <= target && target < nums[m] {
                    setR()
                } else {
                    setL()
                }
            } else {
                if nums[m] < target && target <= nums[r] {
                    setL()
                } else {
                    setR()
                }
            }
        }
        return -1
    }

    // can solve with one-loop
    func _search(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        // find the demarcation point
        var left = 0, right = n - 1
        var bound = 0
        while nums[left] > nums[right] {
            let mid = (left + right) / 2
            if mid == left {
                bound = mid
                break
            }
            if nums[mid] < nums[right] {
                right = mid
            } else {
                left = mid
            }
        }
        print("\(bound), k = \(n - 1 - bound)")

        func _search(_ nums: [Int], left: Int, right: Int) -> Int {
            var left = left, right = right
            while left <= right {
                let mid = left + (right - left) / 2
                if nums[mid] == target {
                    return mid
                } else if nums[mid] < target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
            return -1
        }
        let ans1 = _search(nums, left: 0, right: bound)
        if ans1 >= 0 {
            return ans1
        }
        let ans2 = _search(nums, left: bound + 1, right: n - 1)
        if ans2 >= 0 {
            return ans2
        }
        return -1
    }
}
// @lc code=end


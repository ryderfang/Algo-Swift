/*
 * @lc app=leetcode id=493 lang=swift
 *
 * [493] Reverse Pairs
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // MARK: Merge Sort
    /*
     1 <= nums.length <= 5 * 10^4
     -2^31 <= nums[i] <= 2^31 - 1
     */
    func reversePairs(_ nums: [Int]) -> Int {
        let n = nums.count
        var count = 0
        var nums = nums
        count = mergeSort(&nums, 0, n - 1)
        return count
    }

    func mergeSort(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
        if left >= right { return 0 }
        let mid = (left + right) / 2
        var count = mergeSort(&nums, left, mid) + mergeSort(&nums, mid + 1, right)

        // solve cross mid situation
        // nums[i] > 2 * nums[j]
        for i in left...mid {
            var j = mid + 1
            while j <= right && nums[i] > 2 * nums[j] {
                j += 1
            }
            count += (j - (mid + 1))
        }

        // merge two sorted subarrays
        var merged = Array(repeating: 0, count: right - left + 1)
        var i = left, j = mid + 1, k = 0
        while i <= mid && j <= right {
            if nums[i] <= nums[j] {
                merged[k] = nums[i]
                i += 1
            } else {
                merged[k] = nums[j]
                j += 1
            }
            k += 1
        }
        while i <= mid {
            merged[k] = nums[i]
            i += 1
            k += 1
        }
        while j <= right {
            merged[k] = nums[j]
            j += 1
            k += 1
        }
        for k in 0..<merged.count {
            nums[left + k] = merged[k]
        }

        return count
    }
}
// @lc code=end

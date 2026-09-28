/*
 * @lc app=leetcode id=41 lang=swift
 *
 * [41] First Missing Positive
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // O(n) + O(1)
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        let n = nums.count
        /* number of swap operation in this nested for and while loop is O(n)
         * e.g.
         * [3, 4, -1, 1]
         * [-1, 4, 3, 1]
         * [-1, 1, 3, 4]
         * [1, -1, 3, 4]
         */

        for i in 0..<n {
            // [1,2,3...] -> nums[i] should be placed at nums[i]-1
            while nums[i] > 0 && nums[i] <= n && nums[nums[i]-1] != nums[i] {
                // each swap got a new correct slot
                nums.swapAt(i, nums[i] - 1)
            }
        }
        for i in 0..<n {
            if nums[i] != i + 1 {
                return i + 1
            }
        }
        return n + 1
    }

    // O(n) + O(n)
    func firstMissingPositive1(_ nums: [Int]) -> Int {
        let n = nums.count
        var ext = [Bool](repeating: false, count: n + 1)
        for x in nums {
            guard x > 0 && x <= n else { continue }
            ext[x] = true
        }
        for i in 1..<n+1 {
            if ext[i] == false {
                return i
            }
        }
        return n + 1
    }
}
// @lc code=end


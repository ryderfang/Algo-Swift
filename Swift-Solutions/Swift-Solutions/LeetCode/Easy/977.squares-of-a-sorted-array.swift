/*
 * @lc app=leetcode id=977 lang=swift
 *
 * [977] Squares of a Sorted Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var i = 0
        while i < n && nums[i] < 0 {
            i += 1
        }
        if i == 0 {
            return nums.map { $0 * $0 }
        } else if i == n {
            return nums.reversed().map { $0 * $0 }
        }
        // nums[i-1] < 0 && nums[i] >= 0
        var j = i - 1
        var ans = [Int]()
        while i < n && j >= 0 {
            let (t1, t2) = (nums[i] * nums[i], nums[j] * nums[j])
            if t1 < t2 {
                ans.append(t1)
                i += 1
            } else if t1 > t2 {
                ans.append(t2)
                j -= 1
            } else {
                ans.append(contentsOf: [t1, t2])
                i += 1
                j -= 1
            }
        }
        while i < n {
            ans.append(nums[i] * nums[i])
            i += 1
        }
        while j >= 0 {
            ans.append(nums[j] * nums[j])
            j -= 1
        }
        return ans
    }
}
// @lc code=end


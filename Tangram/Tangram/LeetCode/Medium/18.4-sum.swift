/*
 * @lc app=leetcode id=18 lang=swift
 *
 * [18] 4Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let nums = nums.sorted()
        let n = nums.count
        guard n >= 4 else { return [] }

        var ans = [[Int]]()
        for a in 0..<n-3 {
            if a > 0 && nums[a] == nums[a-1] { continue }
            for b in a+1..<n {
                if b > a+1 && nums[b] == nums[b-1] { continue }
                let x = target - nums[a] - nums[b]
                var l = b + 1, r = n - 1
                while l < r {
                    let sum = nums[l] + nums[r]
                    if sum == x {
                        ans.append([nums[a], nums[b], nums[l], nums[r]])
                        l += 1
                        r -= 1
                        while l < r && nums[l] == nums[l - 1] { l += 1 }
                        while l < r && nums[r] == nums[r + 1] { r -= 1 }
                    } else {
                        sum > x ? r -= 1 : (l += 1)
                    }
                }
            }
        }
        return ans
    }
}
// @lc code=end


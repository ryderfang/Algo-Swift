/*
 * @lc app=leetcode id=39 lang=swift
 *
 * [39] Combination Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let nums = candidates.sorted()
        func _combi(_ nums: [Int], _ target: Int) -> [[Int]] {
            let n = nums.count
            guard n > 0 else { return [] }
            if nums[0] > target {
                return []
            }
            var ans = [[Int]]()
            for i in 0... {
                let x = target - nums[0] * i
                let prefix = [Int](repeating: nums[0], count: i)
                if x < nums[0] {
                    break
                } else if x == nums[0] {
                    ans.append(prefix + [nums[0]])
                    break
                }
                let next = _combi(Array(nums[1...]), x)
                for t in next {
                    ans.append(prefix + t)
                }
            }
            return ans
        }
        return _combi(nums, target)
    }
}
// @lc code=end


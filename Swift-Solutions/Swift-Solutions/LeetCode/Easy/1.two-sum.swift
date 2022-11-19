/*
 * @lc app=leetcode id=1 lang=swift
 *
 * [1] Two Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func _twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var mp = [Int: Int]()
        for (i, x) in nums.enumerated() {
            if let last = mp[target - x] {
                return [last, i]
            }

            if mp[x] == nil {
                mp[x] = i
            }
        }
        return []
    }

    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        return twoSumPlus(nums, target).first!
    }

    func twoSumPlus(_ nums: [Int], _ target: Int) -> [[Int]] {
        var sorts = [(Int, Int)]()
        let n = nums.count
        guard n >= 2 else { return [] }
        for (i, x) in nums.enumerated() {
            sorts.append((x, i))
        }
        sorts = sorts.sorted(by: { $0.0 < $1.0 })
        var l = 0, r = n - 1
        var ans = [[Int]]()
        while l < r {
            let sum = sorts[l].0 + sorts[r].0
            if sum == target {
                ans.append([sorts[l].1, sorts[r].1])
//                print(sorts[l].0, sorts[r].0)
                l += 1
                r -= 1
                while l < r && nums[l] == nums[l-1] { l += 1 }
                while l < r && nums[r] == nums[r+1] { r -= 1 }
            } else {
                sum > target ? r -= 1 : (l += 1)
            }
        }
        return ans
    }
}
// @lc code=end


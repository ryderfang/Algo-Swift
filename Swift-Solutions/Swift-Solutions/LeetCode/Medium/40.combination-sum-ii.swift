/*
 * @lc app=leetcode id=40 lang=swift
 *
 * [40] Combination Sum II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var mp = [Int: Int]()
        for x in candidates {
            mp[x, default: 0] += 1
        }
        let nums = Array(Set(candidates)).sorted()

        func _combi(_ nums: [Int], _ target: Int, _ mp: [Int: Int]) -> [[Int]] {
            let n = nums.count
            guard n > 0 else { return [] }
            if nums[0] > target {
                return []
            }

            var ans = [[Int]]()
            let count = mp[nums[0], default: 0]
            for i in 0...count {
                let x = target - i * nums[0]
                let prefix = [Int](repeating: nums[0], count: i)
                if x < nums[0] {
                    break
                } else if x == nums[0] {
                    if i + 1 <= count {
                        ans.append(prefix + [nums[0]])
                    }
                    break
                }
                var mmp = mp
                mmp[nums[0]] = count - i
                let next = _combi(Array(nums[1...]), target - i * nums[0], mmp)
                for t in next {
                    ans.append(prefix + t)
                }
            }
            return ans
        }
        return _combi(nums, target, mp)
    }
}
// @lc code=end


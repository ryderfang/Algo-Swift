/*
 * @lc app=leetcode id=645 lang=swift
 *
 * [645] Set Mismatch
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] {
        let n = nums.count
        let actualSum = n * (n + 1) / 2
        let sum = nums.reduce(0, +)
        let diff = abs(sum - actualSum)
        var mp = [Int: Int]()
        var duplicated = -1
        for x in nums {
            mp[x, default: 0] += 1
            if mp[x, default: 0] == 2 {
                duplicated = x
                break
            }
        }
        return [duplicated, (sum > actualSum ? duplicated - diff : duplicated + diff)]
    }
}
// @lc code=end


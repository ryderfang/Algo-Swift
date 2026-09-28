/*
 * @lc app=leetcode id=448 lang=swift
 *
 * [448] Find All Numbers Disappeared in an Array
 */

// @lc code=start
extension Solution {
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var ans = [Int](repeating: 1, count: n + 1)
        ans[0] = 0
        for x in nums {
            ans[x] = 0
        }
        return ans.enumerated().map { (i, x) in
            x > 0 ? i : -1
        }.filter { $0 > 0 }
    }
}
// @lc code=end


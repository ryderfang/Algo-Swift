/*
 * @lc app=leetcode id=78 lang=swift
 *
 * [78] Subsets
 */

// @lc code=start
extension Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var ans = [[Int]]()
        let n = nums.count
        func _p(_ index: Int, _ res: [Int]) {
            ans.append(res)
            for i in index..<n {
                var tmp = res
                tmp.append(nums[i])
                _p(i + 1, tmp)
                tmp.removeLast()
            }
        }
        _p(0, [])
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=90 lang=swift
 *
 * [90] Subsets II
 */

// @lc code=start
class Solution {
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }

        let n = nums.count
        var ans: [[Int]] = [[]]
        let a = nums.sorted()
        func _backTracking(_ index: Int, _ result: inout [Int]) {
            guard index < n else {
                return
            }
            for i in index..<n {
                if (i > index && a[i] == a[i-1]) {
                    continue
                }
                result.append(a[i])
                ans.append(result)
                _backTracking(i + 1, &result)
                result.removeLast()
            }
        }
        
        var tmp: [Int] = []
        _backTracking(0, &tmp)
        return ans
    }
}
// @lc code=end


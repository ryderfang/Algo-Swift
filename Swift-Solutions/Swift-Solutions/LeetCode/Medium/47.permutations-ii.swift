/*
 * @lc app=leetcode id=47 lang=swift
 *
 * [47] Permutations II
 */

// @lc code=start
extension Solution {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }

        let n = nums.count
        var ans = [[Int]]()
        var used = [Bool](repeating: false, count: n)
        let a = nums.sorted()
        func _backTracking(locatedAt index: Int, with result: inout [Int]) -> Void {
            guard index < n else {
                ans.append(result)
                return
            }
            for i in 0..<n {
                if used[i] {
                    continue
                } else if (i > 0 && a[i] == a[i-1] && !used[i-1]) {
                    continue
                }
                result.append(a[i])
                used[i] = true
                _backTracking(locatedAt: index + 1, with: &result)
                used[i] = false
                result.removeLast()
            }
        }
        
        var tmp = [Int]()
        _backTracking(locatedAt: 0, with: &tmp)
        return ans
    }
}
// @lc code=end


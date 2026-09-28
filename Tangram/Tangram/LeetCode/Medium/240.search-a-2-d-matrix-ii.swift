/*
 * @lc app=leetcode id=240 lang=swift
 *
 * [240] Search a 2D Matrix II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count, n = matrix[0].count
        func _search(_ nums: [Int], _ t: Int) -> Int {
            var (l, r) = (0, nums.count)
            while l < r {
                let m = l + (r - l) / 2
                if nums[m] < target {
                    l = m + 1
                } else {
                    r = m
                }
            }
            return l
        }
        var r = _search(matrix.map { $0[0] }, target)
        r = min(r, m - 1)
        if matrix[r][0] == target {
            return true
        }
        var c = _search(matrix[0], target)
        c = min(c, n - 1)
        if matrix[0][c] == target {
            return true
        }
        for i in 0...r {
            let t = _search(Array(matrix[i][0...c]), target)
            if t < n && matrix[i][t] == target {
                 return true
            }
        }
        return false
    }
}
// @lc code=end


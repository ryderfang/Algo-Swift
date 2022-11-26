/*
 * @lc app=leetcode id=74 lang=swift
 *
 * [74] Search a 2D Matrix
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        let n = matrix[0].count
        if target < matrix[0][0] || matrix[m-1][n-1] < target {
            return false
        }
        var l = 0, r = m - 1
        var row = 0
        while l < r {
            let mid = (l + r) / 2
            if matrix[mid][0] <= target && target <= matrix[mid][n-1] {
                row = mid
                break
            } else if target < matrix[mid][0] {
                r = mid - 1
            } else if target > matrix[mid][n-1] {
                l = mid + 1
            }
        }
        if matrix[l][0] <= target && target <= matrix[l][n-1] {
            row = l
        }
        l = 0
        r = n - 1
        while l < r {
            let mid = (l + r) / 2
            let now = matrix[row][mid]
            if now == target {
                return true
            } else if now > target {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        return matrix[row][l] == target
    }
}
// @lc code=end


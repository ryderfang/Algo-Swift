/*
 * @lc app=leetcode id=1504 lang=swift
 *
 * [1504] Count Submatrices With All Ones
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Solution from Hints
    func numSubmat(_ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count
        var heights = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                if mat[i][j] == 1 {
                    heights[i][j] = (i == 0) ? 1 : (heights[i-1][j] + 1)
                }
            }
        }
        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                var minHeight = heights[i][j]
                for k in j..<n {
                    minHeight = min(minHeight, heights[i][k])
                    ans += minHeight
                }
            }
        }
        return ans
    }

    // m, n <- [1, 150]
    func numSubmat1(_ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count
        // ans of last row
        var tmp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                // fact = nums[j]*nums[j+1]*...*nums[k]
                var fact = 1
                for k in j..<n {
                    fact *= mat[i][k]
                    /*
                     * fact = 0 -> cur = 0
                     * fact = 1 -> cur = 1 + last
                     */
                    let cur = (fact + tmp[j][k] * fact)
                    ans += cur
                    tmp[j][k] = cur
                }
            }
        }
        return ans
    }
}
// @lc code=end


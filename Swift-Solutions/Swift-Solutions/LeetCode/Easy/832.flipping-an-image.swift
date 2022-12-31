/*
 * @lc app=leetcode id=832 lang=swift
 *
 * [832] Flipping an Image
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func flipAndInvertImage(_ image: [[Int]]) -> [[Int]] {
        let m = image.count
        let n = image[0].count
        var ans = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                ans[i][j] = 1 - image[i][n-1-j]
            }
        }
        return ans
    }
}
// @lc code=end


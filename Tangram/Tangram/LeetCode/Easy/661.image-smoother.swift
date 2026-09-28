/*
 * @lc app=leetcode id=661 lang=swift
 *
 * [661] Image Smoother
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func imageSmoother(_ img: [[Int]]) -> [[Int]] {
        let m = img.count
        let n = img[0].count
        var ans = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                var sum = img[i][j]
                var count = 1
                if j > 0 {
                    sum += img[i][j-1]
                    count += 1
                }
                if j < n - 1 {
                    sum += img[i][j+1]
                    count += 1
                }
                if i > 0 {
                    sum += img[i-1][j]
                    count += 1
                    if j > 0 {
                        sum += img[i-1][j-1]
                        count += 1
                    }
                    if j < n - 1 {
                        sum += img[i-1][j+1]
                        count += 1
                    }
                }
                if i < m - 1 {
                    sum += img[i+1][j]
                    count += 1
                    if j > 0 {
                        sum += img[i+1][j-1]
                        count += 1
                    }
                    if j < n - 1 {
                        sum += img[i+1][j+1]
                        count += 1
                    }
                }
                ans[i][j] = sum / count
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=221 lang=swift
 *
 * [221] Maximal Square
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        let m = matrix.count
        let n = matrix[0].count
        let r = min(m, n)
        var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: r + 1), count: n), count: m)
        var ans = [[(Int, Int)]](repeating: [(Int, Int)](), count: r + 1)
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] == "1" {
                    dp[i][j][1] = 1
                    ans[1].append((i, j))
                } else {
                    dp[i][j][1] = 0
                }
            }
        }
        guard ans[1].count > 0 else { return 0 }
        var ret = 2
        while true {
            for p in ans[ret-1] {
                // (i, j, k) = {(i+1,j+1,k-1) && (i+k-1,j,1) && (i,j+k-1,1)}
                let (i, j) = (p.0, p.1)
                guard i + ret <= m && j + ret <= n else { continue }
                guard dp[i+1][j+1][ret-1] == 1 else { continue }
                if dp[i+ret-1][j][1] == 1 && dp[i][j+ret-1][1] == 1 {
                    dp[i][j][ret] = 1
                    ans[ret].append((i, j))
                }
            }
            if ret > r || ans[ret].count == 0 {
                break
            }
            ret += 1
        }
        return (ret - 1) * (ret - 1)
    }
}
// @lc code=end


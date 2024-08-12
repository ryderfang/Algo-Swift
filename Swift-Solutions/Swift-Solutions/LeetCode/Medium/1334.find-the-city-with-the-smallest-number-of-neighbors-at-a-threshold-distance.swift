/*
 * @lc app=leetcode id=1334 lang=swift
 *
 * [1334] Find the City With the Smallest Number of Neighbors at a Threshold Distance
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func findTheCity(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
        for i in 0..<n {
            dp[i][i] = 0
        }
        for e in edges {
            let (from, to, dis) = (e[0], e[1], e[2])
            dp[from][to] = dis
            dp[to][from] = dis
        }
        // Floyd-Warshall 算法
        // k must in outer-most layer
        for k in 0..<n {
            for i in 0..<n {
                for j in 0..<n {
                    guard dp[i][k] < Int.max && dp[k][j] < Int.max else { continue }
                    if dp[i][j] > dp[i][k] + dp[k][j] {
                        dp[i][j] = dp[i][k] + dp[k][j]
                    }
                }
            }
        }
        var minCount = n
        var ret = n
        for i in stride(from: n - 1, through: 0, by: -1) {
            var tmp = 0
            for j in 0..<n {
                if i != j && dp[i][j] <= distanceThreshold {
                    tmp += 1
                }
            }
            if tmp < minCount {
                minCount = tmp
                ret = i
            }
            print(i, tmp)
        }
        return ret
    }
}
// @lc code=end


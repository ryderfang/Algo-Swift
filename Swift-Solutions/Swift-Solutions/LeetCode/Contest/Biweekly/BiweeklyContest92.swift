//
//  BiweeklyContest.swift
//  Titan
//
//  Created by ryfang on 2022/11/26.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 2481
    func numberOfCuts(_ n: Int) -> Int {
        guard n > 1 else { return 0 }
        if n & 1 == 0 {
            return n
        } else {
            return n / 2
        }
    }

    // 2482
    func onesMinusZeros(_ grid: [[Int]]) -> [[Int]] {
        let m = grid.count
        let n = grid[0].count
        var onesRow = [Int](repeating: 0, count: m)
        var onesCol = [Int](repeating: 0, count: n)
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    onesRow[i] += 1
                }
            }
        }
        for j in 0..<n {
            for i in 0..<m {
                if grid[i][j] == 1 {
                    onesCol[j] += 1
                }
            }
        }
        var diff = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - n - m
            }
        }
        return diff
    }

    // 2483
    func bestClosingTime(_ customers: String) -> Int {
        let n = customers.count
        var lessN = [Int](repeating: 0, count: n+1)
        var minimum = 0
        var ans = 0
        // penalty = lessN[i] + (n - i - (lessN[n] - lessN[i]))
        for (i, ch) in customers.enumerated() {
            lessN[i+1] = lessN[i] + (ch == "N" ? 1 : 0)
            if lessN[i+1] * 2 - (i+1) < minimum {
                minimum = lessN[i+1] * 2 - (i+1)
                ans = i+1
            }
        }
        print(n - lessN[n] + minimum, ans)
        return ans
    }
}
// @lc code=end

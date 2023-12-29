/*
 * @lc app=leetcode id=2101 lang=swift
 *
 * [2101] Detonate the Maximum Bombs
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maximumDetonation(_ bombs: [[Int]]) -> Int {
        let n = bombs.count
        func _search(_ i: Int, _ visited: inout Set<Int>, _ dp: inout [Int]) -> Int {
            visited.insert(i)
            guard dp[i] == 0 else { return dp[i] }
            let (xi, yi, ri) = (bombs[i][0], bombs[i][1], bombs[i][2])
            var ret = 1
            for j in 0..<n {
                guard !visited.contains(j) else { continue }
                let (xj, yj, _) = (bombs[j][0], bombs[j][1], bombs[j][2])
                if (xj - xi) * (xj - xi) + (yj - yi) * (yj - yi) <= ri * ri {
                    ret += _search(j, &visited, &dp)
                }
            }
            dp[i] = ret
            return ret
        }
        var ans = 0
        for i in 0..<n {
            var dp = [Int](repeating: 0, count: n)
            var visited = Set<Int>()
            ans = max(ans, _search(i, &visited, &dp))
        }
        return ans
    }
}
// @lc code=end

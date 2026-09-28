/*
 * @lc app=leetcode id=1130 lang=swift
 *
 * [1130] Minimum Cost Tree From Leaf Values
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Minimum Cost Tree
    func mctFromLeafValues(_ arr: [Int]) -> Int {
        let n = arr.count
        // (res, max of [i,j])
        var dp = [[(Int, Int)]](repeating: [(Int, Int)](repeating: (0, 0), count: n), count: n)
        func _solve(_ i: Int, _ j: Int) -> (Int, Int) {
            guard j >= i else { return (0, 0) }
            if dp[i][j].1 > 0 { return dp[i][j] }
            if j == i {
                dp[i][j] = (0, arr[i])
                return dp[i][j]
            }
            var (ret, maxv) = (Int.max, arr[j])
            if j == i + 1 {
                ret = arr[i] * arr[j]
                maxv = max(arr[i], arr[j])
            } else {
                for k in i..<j {
                    maxv = max(maxv, arr[k])
                    let left = _solve(i, k)
                    let right = _solve(k+1, j)
                    ret = min(ret, left.0 + right.0 + left.1 * right.1)
                }
            }
            dp[i][j] = (ret, maxv)
            return dp[i][j]
        }
        return _solve(0, n-1).0
    }
}
// @lc code=end

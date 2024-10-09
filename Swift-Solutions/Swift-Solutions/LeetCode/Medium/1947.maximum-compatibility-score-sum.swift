/*
 * @lc app=leetcode id=1947 lang=swift
 *
 * [1947] Maximum Compatibility Score Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    // -> use a bit array (mask) instead of visited array.
    func maxCompatibilitySum(_ students: [[Int]], _ mentors: [[Int]]) -> Int {
        let m = students.count
        func _score(_ s: [Int], _ m: [Int]) -> Int {
            return zip(s, m).reduce(0, { res, elem in
                res + (elem.0 == elem.1 ? 1 : 0)
            })
        }
        // count is (1 << m)
        var dp = [Int](repeating: -1, count: (1 << m))
        func _solve(_ mask: Int) -> Int {
            let i = mask.nonzeroBitCount
            guard i < m else { return 0 }
            guard dp[mask] < 0 else { return dp[mask] }
            var ans = 0
            for j in 0..<m {
                // not visited
                guard mask & (1 << j) == 0 else { continue }
                let score = _score(students[j], mentors[i])
                ans = max(ans, score + _solve(mask | (1 << j)))
            }
            dp[mask] = ans
            return ans
        }
        return _solve(0)
    }
    
    func maxCompatibilitySum1(_ students: [[Int]], _ mentors: [[Int]]) -> Int {
        let n = students.count
        func _score(_ a: [Int], _ b: [Int]) -> Int {
            var ret = 0
            for i in 0..<a.count {
                if a[i] == b[i] { ret += 1 }
            }
            return ret
        }
        var visited = [[Int]](repeating: [Int](repeating: -1, count: n), count: n)
        var ans = 0
        func _solve(_ i: Int, _ j: Int, _ tmp: Int) {
            guard j < n else {
                ans = max(ans, tmp)
                return
            }
            for k in 0..<n {
                if visited[i][k] < 0 {
                    visited[i][k] = j
                    _solve(i, j+1, tmp + _score(students[j], mentors[k]))
                    visited[i][k] = -1
                }
            }
        }
        for i in 0..<n {
            for j in 0..<n {
                _solve(i, j, 0)
            }
        }
        return ans
    }
}
// @lc code=end


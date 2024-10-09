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
    func maxCompatibilitySum(_ students: [[Int]], _ mentors: [[Int]]) -> Int {
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


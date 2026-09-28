/*
 * @lc app=leetcode id=997 lang=swift
 *
 * [997] Find the Town Judge
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
        var a = [Int](repeating: 0, count: n + 1)
        var b = [Int](repeating: 0, count: n + 1)
        for t in trust {
            a[t[0]] += 1
            b[t[1]] += 1
        }
        for i in 1...n {
            if a[i] == 0 && b[i] == n - 1 {
                return i
            }
        }
        return -1
    }
}
// @lc code=end


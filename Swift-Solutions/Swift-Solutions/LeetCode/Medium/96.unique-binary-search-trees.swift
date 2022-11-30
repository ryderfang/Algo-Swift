/*
 * @lc app=leetcode id=96 lang=swift
 *
 * [96] Unique Binary Search Trees
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numTrees(_ n: Int) -> Int {
        let _ = [0, 1, 2, 5, 14, 42, 132, 429, 1430, 4862, 16796,
                   58786, 208012, 742900, 2674440, 9694845, 35357670,
                   129644790, 477638700, 1767263190
        ]

        var f = [Int](repeating: 0, count: 20)
        f[0] = 1
        f[1] = 1
        // for f[i], root = [1...i]
        // root = j -> count = left * right = f[j-1] * f[i-j]
        for i in 2...19 {
            var count = 0
            for j in 1...i {
                count += f[j-1] * f[i-j]
            }
            f[i] = count
        }
        return f[n]
    }
}
// @lc code=end


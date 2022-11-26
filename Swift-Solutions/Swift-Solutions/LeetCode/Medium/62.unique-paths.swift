/*
 * @lc app=leetcode id=62 lang=swift
 *
 * [62] Unique Paths
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 1 && n > 1 else { return 1 }
        // (a + b)! / (a! * b!)
        let a = max(m - 1, n - 1)
        let b = min(m - 1, n - 1)
        var ans = 1
        // (a+1)(a+2)...(a+b)/b!
        for x in a+1...a+b {
            ans = ans * x / (x - a)
        }
        return ans
    }
}
// @lc code=end


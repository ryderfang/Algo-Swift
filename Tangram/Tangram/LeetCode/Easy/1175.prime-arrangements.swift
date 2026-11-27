/*
 * @lc app=leetcode id=1175 lang=swift
 *
 * [1175] Prime Arrangements
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func numPrimeArrangements(_ n: Int) -> Int {
        guard n > 1 else { return 1 }
        let pu100 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        let mod = Int(1e9 + 7)
        let pc = pu100.count(where: { $0 <= n })
        let npc = n - pc
        // pc! * npc!
        var ans = 1
        for i in 1...pc {
            ans = ((ans % mod) * (i % mod)) % mod
        }
        for i in 1...npc {
            ans = ((ans % mod) * (i % mod)) % mod
        }
        return ans
    }
}
// @lc code=end

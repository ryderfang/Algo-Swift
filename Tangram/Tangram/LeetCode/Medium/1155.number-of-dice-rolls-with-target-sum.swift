/*
 * @lc app=leetcode id=1155 lang=swift
 *
 * [1155] Number of Dice Rolls With Target Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func numRollsToTarget(_ n: Int, _ k: Int, _ target: Int) -> Int {
        let mod = Int(1e9 + 7)
        var store = [[Int]](repeating: [Int](repeating: 0, count: target + 1), count: n + 1)
        for i in 0...n {
            store[i][0] = 0
        }
        for j in 0...target {
            store[0][j] = 0
            store[1][j] = (j <= k ? 1 : 0)
        }
        guard n > 1 else { return store[n][target] }
        for i in 2...n {
            for j in 1...target {
                if j < i {
                    store[i][j] = 0
                    continue
                }
                let maxRoll = min(k, j - 1)
                if maxRoll >= 1 {
                    for k in 1...maxRoll {
                        store[i][j] = (store[i][j] % mod + store[i-1][j-k] % mod) % mod
                    }
                }
            }
        }
        return store[n][target]
    }
}
// @lc code=end


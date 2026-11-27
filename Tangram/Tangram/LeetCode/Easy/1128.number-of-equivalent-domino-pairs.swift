/*
 * @lc app=leetcode id=1128 lang=swift
 *
 * [1128] Number of Equivalent Domino Pairs
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func numEquivDominoPairs(_ dominoes: [[Int]]) -> Int {
        let n = dominoes.count
        let tmp = dominoes.map { item in
            let x = min(item[0], item[1])
            let y = max(item[0], item[1])
            return x * 10 + y
        }.sorted()
        var ans = 0
        var cnt = 1
        for i in 1..<n {
            if tmp[i] == tmp[i-1] {
                cnt += 1
                if i < n - 1 {
                    continue
                }
            }
            // C(cnt, 2)
            if cnt >= 2 {
                ans += (cnt - 1) * cnt / 2
            }
            cnt = 1
        }
        return ans
    }
}
// @lc code=end

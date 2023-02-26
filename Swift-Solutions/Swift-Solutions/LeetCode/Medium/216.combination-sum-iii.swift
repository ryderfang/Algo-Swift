/*
 * @lc app=leetcode id=216 lang=swift
 *
 * [216] Combination Sum III
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    typealias SI = Set<Int>
    typealias SSI = Set<SI>

    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var s = [[SSI]](repeating: [SSI](repeating: SSI(), count: 61), count: 10)
        for i in 1...9 {
            s[1][i].insert([i])
        }
        for i in 2...k {
            for j in 1...60 {
                let pre = s[i-1][j]
                guard pre.count > 0 else { continue }
                for p in pre {
                    for k in 1...9 {
                        guard j + k <= 60 else { break }
                        guard !p.contains(k) else { continue }
                        s[i][j + k].insert(p.union([k]))
                    }
                }
            }
        }
        // 去重
        let ans = Array(s[k][n].map { Array($0).sorted() })
        return ans
    }
}
// @lc code=end


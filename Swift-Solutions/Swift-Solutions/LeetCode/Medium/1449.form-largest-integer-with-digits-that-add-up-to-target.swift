/*
 * @lc app=leetcode id=1449 lang=swift
 *
 * [1449] Form Largest Integer With Digits That Add up to Target
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func largestNumber(_ cost: [Int], _ target: Int) -> String {
        var dp = [String](repeating: "", count: target + 1)
        // pick the largest number of same cost
        var pack = [Int: Int]()
        for (i, c) in cost.enumerated() {
            pack[c] = max(pack[c, default: 0], i + 1)
        }
        for (cost, digit) in pack {
            guard cost <= target else { continue }
            for v in cost...target {
                if v == cost {
                    dp[v] = max(dp[v], String(digit))
                } else {
                    // sort
                    var tmp = dp[v-cost]
                    if dp[v].count > tmp.count + 1 {
                        continue
                    }
                    if tmp != "" {
                        tmp += String(digit)
                        tmp = String(tmp.sorted(by: { $0 > $1 }))
                    }
                    if dp[v].count < tmp.count {
                        dp[v] = tmp
                    } else if dp[v].count == tmp.count {
                        dp[v] = max(dp[v], tmp)
                    }
                }
            }
        }
        return dp[target] == "" ? "0": dp[target]
    }
}
// @lc code=end


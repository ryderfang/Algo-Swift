/*
 * @lc app=leetcode id=274 lang=swift
 *
 * [274] H-Index
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func hIndex1(_ citations: [Int]) -> Int {
        let sorted = citations.sorted(by: >)
        let n = citations.count
        var ans = n
        while ans > 0 {
            if sorted[ans-1] >= ans {
                break
            }
            ans -= 1
        }
        return ans
    }
}
// @lc code=end


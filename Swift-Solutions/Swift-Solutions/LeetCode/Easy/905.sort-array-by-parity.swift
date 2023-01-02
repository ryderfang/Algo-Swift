/*
 * @lc app=leetcode id=905 lang=swift
 *
 * [905] Sort Array By Parity
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func sortArrayByParity(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var ans = nums
        guard n > 1 else { return ans }
        var (p, q) = (0, n - 1)
        while p < q {
            while p < q && ans[p] % 2 == 0 {
                p += 1
            }
            while p < q && ans[q] % 2 == 1 {
                q -= 1
            }
            if p < q {
                ans.swapAt(p, q)
            }
        }
        return ans
    }
}
// @lc code=end


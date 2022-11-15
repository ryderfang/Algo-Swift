/*
 * @lc app=leetcode id=11 lang=swift
 *
 * [11] Container With Most Water
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // opt: 双指针
    // lhs = 0, rhs = n - 1
    // val = max(val, min(h[lhs], h[rhs]) * (rhs - lhs))
    // h[lhs] < h[rhs] ? (lhs += 1) : (rhs -= 1)
    func maxArea(_ height: [Int]) -> Int {
        var ans = 0
        var maxHeight = 0
        for h in height {
            maxHeight = max(h, maxHeight)
        }
        guard maxHeight > 0 else { return 0 }
        for i in 1...maxHeight {
            if let left = height.firstIndex(where: { $0 >= i }),
               let right = height.lastIndex(where: { $0 >= i }) {
                ans = max((right - left) * i, ans)
            }
        }
        return ans
    }
}
// @lc code=end


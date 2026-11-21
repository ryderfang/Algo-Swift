/*
 * @lc app=leetcode id=1046 lang=swift
 *
 * [1046] Last Stone Weight
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {
        var sorted = stones.sorted(by: >)
        while sorted.count >= 2 {
            let (x, y) = (sorted.removeFirst(), sorted.removeFirst())
            if x != y {
                sorted.append(x - y)
                sorted.sort(by: >)
            }
        }
        return sorted.first ?? 0
    }
}
// @lc code=end

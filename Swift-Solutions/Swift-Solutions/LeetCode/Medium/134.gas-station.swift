/*
 * @lc app=leetcode id=134 lang=swift
 *
 * [134] Gas Station
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        let n = gas.count
        var diff = gas.enumerated().map { $0.element - cost[$0.offset] }
        let sum = diff.reduce(0, +)
        if sum < 0 {
            return -1
        }
        guard n > 1 else { return diff[0] >= 0 ? 0 : -1 }
        for i in 0..<n {
            guard diff[i] > 0 else { continue }
            var sum = 0, j = 0
            while sum >= 0, j < n {
                sum += diff[(i+j)%n]
                j += 1
            }
            if j == n {
                return i
            }
        }
        return -1
    }
}
// @lc code=end


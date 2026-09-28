/*
 * @lc app=leetcode id=179 lang=swift
 *
 * [179] Largest Number
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func largestNumber(_ nums: [Int]) -> String {
        return nums.map { String($0) }
            .sorted(by: { $0 + $1 > $1 + $0 })
            .joined()
            .removeLeadingZeros()
    }
}

fileprivate extension String {
    // remove leading zeros
    func removeLeadingZeros() -> String {
        guard let idx = self.firstIndex(where: { $0 != "0" }),
              idx < self.endIndex else { return "0" }
        return String(self[idx..<self.endIndex])
    }
}

// @lc code=end

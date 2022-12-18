/*
 * @lc app=leetcode id=682 lang=swift
 *
 * [682] Baseball Game
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func calPoints(_ operations: [String]) -> Int {
        var nums = [Int]()
        for op in operations {
            switch op {
            case "+":
                let n1 = nums.removeLast()
                let n2 = nums.removeLast()
                nums.append(contentsOf: [n2, n1, n1 + n2])
            case "D":
                let n = nums.removeLast()
                nums.append(contentsOf: [n, n * 2])
            case "C":
                nums.removeLast()
            default:
                if let n = Int(op) {
                    nums.append(n)
                }
            }
        }
        return nums.reduce(0, +)
    }
}
// @lc code=end


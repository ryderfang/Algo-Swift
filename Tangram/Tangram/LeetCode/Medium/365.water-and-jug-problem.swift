/*
 * @lc app=leetcode id=365 lang=swift
 *
 * [365] Water and Jug Problem
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 22003, 31237, 1
    func canMeasureWater(_ jug1Capacity: Int, _ jug2Capacity: Int, _ targetCapacity: Int) -> Bool {
        guard targetCapacity <= jug1Capacity + jug2Capacity else { return false }
        let a = max(jug1Capacity, jug2Capacity)
        let b = min(jug1Capacity, jug2Capacity)
        if a == b {
            return targetCapacity == a
        }
        // m * a - n * b
        for i in 1...1000000 {
            guard i * a > targetCapacity else { continue }
            if (i * a - targetCapacity) % b == 0 {
                print("\(i), \((i * a - targetCapacity) / b)")
                return true
            }
        }
        return false
    }
}
// @lc code=end

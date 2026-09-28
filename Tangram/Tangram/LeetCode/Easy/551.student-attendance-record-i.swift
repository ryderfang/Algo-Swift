/*
 * @lc app=leetcode id=551 lang=swift
 *
 * [551] Student Attendance Record I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func checkRecord(_ s: String) -> Bool {
        var absentCount = 0, lateCount = 0
        for ch in s {
            switch ch {
            case "A":
                absentCount += 1
                lateCount = 0
                guard absentCount < 2 else { return false }
            case "L":
                lateCount += 1
                guard lateCount < 3 else { return false }
                break
            default:
                lateCount = 0
                break
            }
        }
        return true
    }
}
// @lc code=end


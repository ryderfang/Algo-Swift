/*
 * @lc app=leetcode id=1154 lang=swift
 *
 * [1154] Day of the Year
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func dayOfYear(_ date: String) -> Int {
        func _isLeapYear(_ year: Int) -> Bool {
            (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
        }
        let tmp = date.split(separator: "-").map {
            Int($0)!
        }
        let (year, month, day) = (tmp[0], tmp[1], tmp[2])
        let dom = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var doy = 0
        for i in 0..<month {
            if i == month - 1 {
                doy += day
            } else {
                doy += dom[i]
                if i == 1 && _isLeapYear(year) {
                    doy += 1
                }
            }
        }
        return doy
    }
}
// @lc code=end

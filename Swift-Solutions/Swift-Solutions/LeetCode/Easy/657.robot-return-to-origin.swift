/*
 * @lc app=leetcode id=657 lang=swift
 *
 * [657] Robot Return to Origin
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func judgeCircle(_ moves: String) -> Bool {
        var (up, down, left, right) = (0, 0, 0, 0)
        for x in moves {
            switch x {
            case "U": up += 1
            case "D": down += 1
            case "L": left += 1
            case "R": right += 1
            default:
                break
            }
        }
        return up == down && left == right
    }
}
// @lc code=end


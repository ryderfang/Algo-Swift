/*
 * @lc app=leetcode id=925 lang=swift
 *
 * [925] Long Pressed Name
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let m = name.count
        let n = typed.count
        guard n >= m else { return false }
        let name = Array(name)
        let typed = Array(typed)
        var (i, j) = (0, 0)
        while i < m && j < n {
            guard name[i] == typed[j] else { return false }
            var count = 0
            i += 1
            while i < m && name[i] == name[i-1] {
                i += 1
                count += 1
            }
            j += 1
            while j < n && typed[j] == typed[j-1] {
                j += 1
                count -= 1
            }
            guard count <= 0 else { return false }
        }
        return i == m && j == n
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=944 lang=swift
 *
 * [944] Delete Columns to Make Sorted
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minDeletionSize(_ strs: [String]) -> Int {
        let strs = strs.map { Array($0) }
        var ans = 0
        let m = strs.count
        let n = strs[0].count
        for i in 0..<n {
            var tmp = [Character]()
            for j in 0..<m {
                tmp.append(strs[j][i])
            }
            if tmp != tmp.sorted() {
                ans += 1
            }
        }
        return ans
    }
}
// @lc code=end


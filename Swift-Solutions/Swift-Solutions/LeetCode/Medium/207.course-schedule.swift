/*
 * @lc app=leetcode id=207 lang=swift
 *
 * [207] Course Schedule
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 有向图是否有环
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        guard prerequisites.count > 0 else { return true }
        var mp = [Int: [Int]]()
        for p in prerequisites {
            mp[p[0], default: []].append(p[1])
        }
        var visited: Set<Int> = []
        func _dfs(_ i: Int, _ visited: inout Set<Int>) {

        }
        return true
    }
}
// @lc code=end


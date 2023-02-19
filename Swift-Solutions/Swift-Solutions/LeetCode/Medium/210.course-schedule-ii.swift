/*
 * @lc app=leetcode id=210 lang=swift
 *
 * [210] Course Schedule II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        guard prerequisites.count > 0 else { return Array(0..<numCourses) }
        var inDegree = [Int](repeating: 0, count: numCourses)
        var graph = [[Int]](repeating: [Int](), count: numCourses)
        for p in prerequisites {
            graph[p[0]].append(p[1])
            inDegree[p[1]] += 1
        }
        // 拓朴排序
        var topoSort = [Int]()
        while let idx = inDegree.firstIndex(where: { $0 == 0 }) {
            topoSort.append(idx)
            inDegree[idx] = -1
            for v in graph[idx] {
                inDegree[v] -= 1
            }
        }
        if topoSort.count == numCourses {
            return Array(topoSort.reversed())
        } else {
            return []
        }
    }
}
// @lc code=end


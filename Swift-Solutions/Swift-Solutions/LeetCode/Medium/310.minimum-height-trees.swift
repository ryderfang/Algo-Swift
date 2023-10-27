/*
 * @lc app=leetcode id=310 lang=swift
 *
 * [310] Minimum Height Trees
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
        guard n > 1 else { return Array(0..<n) }
        var graph = [[Int]](repeating: [Int](), count: n)
        for e in edges {
            graph[e[0]].append(e[1])
            graph[e[1]].append(e[0])
        }
        // 拓朴排序 Topological Sort
        var leaves = (0..<n).filter { graph[$0].count == 1 }
        var remaining = n
        while remaining > 2 {
            remaining -= leaves.count
            leaves = leaves.reduce(into: [Int]()) { result, leaf in
                for adjacent in graph[leaf] {
                    graph[adjacent].removeAll(where: { $0 == leaf })
                }
                result += graph[leaf].filter { graph[$0].count == 1 }
            }
        }
        return leaves
    }

}
// @lc code=end


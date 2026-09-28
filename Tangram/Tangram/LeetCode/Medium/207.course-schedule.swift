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
    // 拓朴排序
    func canFinish1(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        guard prerequisites.count > 0 else { return true }
        var inDegree = [Int](repeating: 0, count: numCourses)
        var graph = [[Int]](repeating: [Int](), count: numCourses)
        for p in prerequisites {
            graph[p[0]].append(p[1])
            inDegree[p[1]] += 1
        }
        // 循环：输出入度为 0 的顶点，并删除它及其起始的边；
        // 能输出所有顶点则无环
        var topoSort = [Int]()
        while let idx = inDegree.firstIndex(where: { $0 == 0 }) {
            topoSort.append(idx)
            inDegree[idx] = -1
            for v in graph[idx] {
                inDegree[v] -= 1
            }
        }
        print(topoSort)
        return topoSort.count == numCourses
    }

    // DFS + Backtrace
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        guard prerequisites.count > 0 else { return true }
        var graph = [[Int]](repeating: [Int](), count: numCourses)
        for p in prerequisites {
            graph[p[0]].append(p[1])
        }

        enum State: Int {
            case unvisited = 0
            case visiting = 1
            case visited = 2
        }
        var state = [State](repeating: .unvisited, count: numCourses)
        func dfs(_ u: Int) -> Bool {
            state[u] = .visiting
            for v in graph[u] {
                guard state[v] != .visiting else {
                    return false
                }
                if state[v] == .unvisited {
                    if !dfs(v) {
                        return false
                    }
                }
            }
            state[u] = .visited
            return true
        }
        for i in 0..<numCourses {
            if state[i] == .unvisited {
                if !dfs(i) {
                    return false
                }
            }
        }
        return true
    }
}

// @lc code=end

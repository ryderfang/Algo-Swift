/*
 * @lc app=leetcode id=399 lang=swift
 *
 * [399] Evaluate Division
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: BFS
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        let graph = zip(equations,values).reduce(into: [String: [String: Double]]()) { graph, tuple in
            let (v0, v1, weight) = (tuple.0[0], tuple.0[1], tuple.1)
            graph[v0, default:[:]][v1] = weight
            graph[v1, default:[:]][v0] = 1.0 / weight
        }

        func bfs(_ query:[String]) -> Double {
            let (start, end) = (query[0], query[1])
            guard graph[start] != nil, graph[end] != nil else { return -1.0 }
            guard start != end else { return 1.0 }
            var q = [(start, 1.0)], visited = Set([start])
            while !q.isEmpty {
                let (node, weight) = q.removeFirst()
                for (adjacentNode, adjacentWeight) in graph[node]! where !visited.contains(adjacentNode) {
                    guard adjacentNode != end else { return weight * adjacentWeight }
                    q.append((adjacentNode, weight * adjacentWeight))
                    visited.insert(adjacentNode)
                }
            }
            return -1.0
        }

        return queries.map(bfs)
    }

    func calcEquation1(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        func _solve(_ u: Int, _ v: Int, _ visited: inout Set<Int>, _ path: [[(Bool, Double, Double)]]) -> (Bool, Double, Double) {
            visited.insert(u)
            var ans = path[u][v]
            if ans.0 == true {
                return ans
            }
            for i in 0..<n {
                guard !visited.contains(i) else { continue }
                let value = path[u][i]
                guard value.0 == true else { continue }
                let ret1 = _solve(u, i, &visited, path)
                let ret2 = _solve(i, v, &visited, path)
                if ret1.0 && ret2.0 {
                    ans.0 = true
                    ans.1 = ret1.1 * ret2.1
                    ans.2 = ret1.2 * ret2.2
                    break
                }
            }
            return ans
        }

        var all: Set<String> = []
        for eq in equations {
            all.insert(eq[0])
            all.insert(eq[1])
        }
        let n = all.count
        let allArr = Array(all)
        var allMap = [String: Int]()
        for i in 0..<n {
            allMap[allArr[i]] = i
        }
        var path = [[(Bool, Double, Double)]](repeating: [(Bool, Double, Double)](repeating: (false, -1.0, -1.0), count: n), count: n)
        for (i, eq) in equations.enumerated() {
            let (u, v) = (allMap[eq[0]]!, allMap[eq[1]]!)
            path[u][v] = (true, values[i], 1.0)
            path[v][u] = (true, 1.0, values[i])
        }
        var ans = [Double]()
        for q in queries {
            guard let u = allMap[q[0]], let v = allMap[q[1]] else {
                ans.append(-1.0)
                continue
            }
            var visited = Set<Int>()
            let ret = _solve(u, v, &visited, path)
            if ret.0 {
                ans.append(ret.1 / ret.2)
            } else {
                ans.append(-1.0)
            }
        }
        return ans
    }
}
// @lc code=end

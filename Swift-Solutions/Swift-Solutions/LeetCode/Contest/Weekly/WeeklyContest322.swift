//
//  WeeklyContest.swift
//  Titan
//
//  Created by ryfang on 2022/11/26.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isCircularSentence(_ sentence: String) -> Bool {
        let words = sentence.components(separatedBy: " ")
        let first = words[0].first!
        var last = words[0].last!
        for x in words.dropFirst() {
            guard x.first == last else { return false }
            last = x.last!
        }
        return first == last
    }

    func dividePlayers(_ skill: [Int]) -> Int {
        let n = skill.count
        guard n > 2 else { return skill[0] * skill[1] }
        var sum = 0
        var mp =  [Int: Int]()
        for x in skill {
            sum += x
            if mp[x, default: -1] < 0 {
                mp[x] = 1
            } else {
                mp[x, default: -1] += 1
            }
        }
        guard sum % (n / 2) == 0 else { return -1 }
        sum /= (n / 2)
        var ans = 0
        for x in skill {
            guard mp[x, default: -1] != 0 else { continue }
            mp[x, default: -1] -= 1
            if mp[sum - x, default: -1] > 0 {
                mp[sum - x, default: -1] -= 1
                ans += (x * (sum - x))
            } else {
                return -1
            }
        }
        return ans
    }

    func minScore(_ n: Int, _ roads: [[Int]]) -> Int {
        var path = [Int: [Int]]()
        for edge in roads {
            path[edge[0], default: []].append(edge[1])
            path[edge[1], default: []].append(edge[0])
        }
        var graph = Set<Int>()
        func _dfs(_ v: Int) {
            graph.insert(v)
            for x in path[v, default: []] {
                guard !graph.contains(x) else { continue }
                _dfs(x)
            }
        }
        _dfs(1)

        var ans = Int.max
        for edge in roads {
            if graph.contains(edge[0]) {
                ans = min(ans, edge[2])
            }
        }
        return ans
    }

    func magnificentSets(_ n: Int, _ edges: [[Int]]) -> Int {
        var path = [Int: [Int]]()
        for edge in edges {
            path[edge[0], default: []].append(edge[1])
            path[edge[1], default: []].append(edge[0])
        }

        // Find Components
        var components = [Int: [Int]]()
        var visit = [Int](repeating: 0, count: n + 1)
        var groupId = 0
        for i in 1...n {
            guard visit[i] == 0 else { continue }
            _dfs(i, &visit, groupId)
            groupId += 1
        }

        // DFS
        func _dfs(_ v: Int, _ visit: inout [Int], _ groupId: Int) {
            visit[v] = 1
            components[groupId, default: []].append(v)
            for x in path[v, default: []] {
                guard visit[x] == 0 else { continue }
                _dfs(x, &visit, groupId)
            }
        }

        func _bfs(_ visited: [Int], _ queue: [Int], _ lastLevel: Set<Int>, _ depth: Int) -> Int {
            var v = visited
            for x in queue {
                v[x] = 1
            }
            var queue = queue.flatMap { path[$0, default: []] }
            let nextLevel = Set(queue)
            if nextLevel.intersection(lastLevel).count > 0 {
                return -1
            }
            queue = Array(nextLevel).filter { v[$0] == 0 }
            guard queue.count > 0 else { return depth }
            return _bfs(v, queue, nextLevel, depth + 1)
        }

        var ans = 0
        for comp in components.values {
            var maxLevel = -1
            for v in comp {
                let tmp = _bfs([Int](repeating: 0, count: n + 1), [v], [], 1)
                guard tmp > 0 else { return -1 }
                maxLevel = max(maxLevel, tmp)
            }
            ans += maxLevel
        }
        return ans
    }
}

// @lc code=end

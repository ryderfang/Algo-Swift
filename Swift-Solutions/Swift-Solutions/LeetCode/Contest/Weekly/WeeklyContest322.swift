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
        var uf = [Int](repeating: -1, count: n + 1)
        for i in 0...n {
            uf[i] = i
        }
        func _find(_ x: Int) -> Int {
            if uf[x] == x {
                return x
            } else {
                uf[x] = _find(uf[x])
                return uf[x]
            }
        }

        func _merge(_ i: Int, _ j: Int) {
            let x = min(i, j)
            let y = max(i, j)
            uf[_find(x)] = _find(y)
        }
        for edge in roads {
            _merge(edge[0], edge[1])
        }
        var ans = Int.max
        for edge in roads {
            if _find(edge[0]) == _find(n) || _find(edge[1]) == _find(n) {
                ans = min(ans, edge[2])
            }
        }
        return ans
    }

    func magnificentSets(_ n: Int, _ edges: [[Int]]) -> Int {
        var uf = [Int](repeating: -1, count: n + 1)
        for i in 0...n {
            uf[i] = i
        }
        func _find(_ x: Int) -> Int {
            if uf[x] == x {
                return x
            } else {
                uf[x] = _find(uf[x])
                return uf[x]
            }
        }

        func _merge(_ i: Int, _ j: Int) {
            let x = min(i, j)
            let y = max(i, j)
            uf[_find(x)] = _find(y)
        }

        var path = [Int: [Int]]()
        var conn = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
        for edge in edges {
            path[edge[0], default: []].append(edge[1])
            path[edge[1], default: []].append(edge[0])
            conn[edge[0]][edge[1]] = 1
            conn[edge[1]][edge[0]] = 1
            _merge(edge[0], edge[1])
        }

        var v = [Int](repeating: 0, count: n + 1)
        v[0] = 1
        func _bfs(_ v: [Int], _ queue: [Int], _ depth: Int, _ count: Int) -> Int {
            var v = v
            for x in queue {
                v[x] = 1
            }
            var queue = queue.flatMap { path[$0, default: []] }
            queue = Array(Set(queue)).filter { v[$0] == 0 }
            let sz = queue.count
            if sz == 0 {
                return depth
            }

            // check connection
            for i in 0..<sz-1 {
                for j in i+1..<sz {
                    if conn[queue[i]][queue[j]] == 1 {
                        return -1
                    }
                }
            }

            return _bfs(v, queue, depth + 1, count + queue.count)
        }

        var dp = [Int](repeating: 0, count: n + 1)
        for i in 1...n {
            let tmp = _bfs(v, [i], 1, 1)
            if tmp > 0 {
                dp[_find(i)] = max(dp[_find(i)], tmp)
            }
        }
        var components = Set<Int>()
        for i in 1...n {
            components.insert(_find(i))
        }
        var ans = 0
        for x in components {
            guard dp[x] > 0 else {
                return -1
            }
            ans += dp[x]
        }
        return ans
    }
}

// @lc code=end

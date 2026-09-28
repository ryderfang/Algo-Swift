//
//  WeeklyContest370.swift
//  Titan
//
//  Created by ryfang on 2023/11/05.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findChampion1(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var ans = Array(0..<n)
        ans.sort(by: { grid[$0][$1] == 1 })
        return ans[0]
    }

    func findChampion(_ n: Int, _ edges: [[Int]]) -> Int {
        var inDegree = [Int](repeating: 0, count: n)
        var graph = [[Int]](repeating: [Int](), count: n)
        for p in edges {
            graph[p[0]].append(p[1])
            inDegree[p[1]] += 1
        }
        if inDegree.filter({ $0 == 0 }).count == 1 {
            return inDegree.firstIndex(of: 0)!
        }
        return -1
    }

    func maximumScoreAfterOperations(_ edges: [[Int]], _ values: [Int]) -> Int {
        class TreeNode {
            var idx: Int
            var val: Int = 0
            var sum: Int = 0
            var childs: [TreeNode] = []
            public init(_ idx: Int) { self.idx = idx }
        }

        let n = edges.count + 1
        var graph = [[Int]](repeating: [Int](), count: n)
        for p in edges {
            graph[p[0]].append(p[1])
            graph[p[1]].append(p[0])
        }
        var visited = [Bool](repeating: false, count: n)
        func _build(_ v: Int) -> TreeNode {
            visited[v] = true
            let childs = graph[v].filter({ visited[$0] == false })
            let node = TreeNode(v)
            node.val = values[v]
            if childs.count == 0 {
                node.sum = values[v]
                return node
            }
            var childNodes: [TreeNode] = []
            for c in childs {
                childNodes.append(_build(c))
            }
            node.sum = node.val + childNodes.reduce(0, { $0 + $1.sum })
            node.childs = childNodes
            return node
        }
        let root = _build(0)
        func _solve(_ node: TreeNode?, _ pick: Bool) -> Int {
            guard let node = node else { return 0 }
            if pick {
                guard node.childs.count > 0 else { return 0 }
                var pickRoot = node.val
                for c in node.childs {
                    pickRoot += max(_solve(c, false), _solve(c, true))
                }
                return pickRoot
            } else {
                return node.sum - node.val
            }
        }
        return max(_solve(root, false), _solve(root, true))
    }
}
// @lc code=end

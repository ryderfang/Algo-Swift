/*
 * @lc app=leetcode id=133 lang=swift
 *
 * [133] Clone Graph
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var neighbors: [Node?]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.neighbors = []
 *     }
 * }
 */

extension Solution {
    func cloneGraph(_ node: Node?) -> Node? {
        guard let node = node else { return nil }
        var clone = [Node](repeating: Node(0), count: 110)
        for i in 0..<110 {
            clone[i] = Node(i)
        }
        var visited = [Int](repeating: 0, count: 110)
        func _dfs(_ node: Node) {
            clone[node.val].val = node.val
            visited[node.val] = 1
            var clonedNeighbors = [Node?]()
            for x in node.neighbors {
                guard let neighbor = x else { continue }
                clonedNeighbors.append(clone[neighbor.val])
                if visited[neighbor.val] == 0 {
                    _dfs(neighbor)
                }
            }
            clone[node.val].neighbors = clonedNeighbors
        }
        _dfs(node)
        return clone[node.val]
    }
}
// @lc code=end


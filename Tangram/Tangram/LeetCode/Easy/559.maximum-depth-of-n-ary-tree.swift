/*
 * @lc app=leetcode id=559 lang=swift
 *
 * [559] Maximum Depth of N-ary Tree
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var children: [Node]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.children = []
 *     }
 * }
 */

extension Solution {
    func maxDepth(_ root: Node?) -> Int {
        guard let root = root else { return 0 }
        return (root.children.map { maxDepth($0) }.max() ?? 0) + 1
    }
}
// @lc code=end


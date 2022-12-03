/*
 * @lc app=leetcode id=117 lang=swift
 *
 * [117] Populating Next Right Pointers in Each Node II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a Node.
 * public extension Node {
 *     public var val: Int
 *     public var left: Node?
 *     public var right: Node?
 *	   public var next: Node?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *         self.next = nil
 *     }
 * }
 */

extension Solution {
    func connect(_ root: Node?) -> Node? {
        guard let root = root else { return nil }
        var tree: [Node] = [root]
        while !tree.isEmpty {
            guard tree.count > 0 else { break }
            for i in 0..<tree.count {
                tree[i].next = i < tree.count - 1 ? tree[i+1] : nil
            }
            tree = tree.flatMap { [$0.left, $0.right].compactMap { $0 } }
        }
        return root
    }
}
// @lc code=end


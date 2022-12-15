/*
 * @lc app=leetcode id=590 lang=swift
 *
 * [590] N-ary Tree Postorder Traversal
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
    func postorder(_ root: Node?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [root]
        while !stack.isEmpty {
            let top = stack.removeLast()
            ans.insert(top.val, at: 0)
            for child in top.children {
                stack.append(child)
            }
        }
        return ans
    }

    func postorder1(_ root: Node?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        func _postorder(_ root: Node?) {
            guard let node = root else { return }
            for child in node.children {
                _postorder(child)
            }
            ans.append(node.val)
        }
        _postorder(root)
        return ans
    }
}
// @lc code=end


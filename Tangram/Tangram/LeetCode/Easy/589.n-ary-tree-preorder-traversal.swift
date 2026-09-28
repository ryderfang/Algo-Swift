/*
 * @lc app=leetcode id=589 lang=swift
 *
 * [589] N-ary Tree Preorder Traversal
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
    // N 叉树前序
    func preorder1(_ root: Node?) -> [Int] {
    	var ans = [Int]()
        func _preorder(_ node: Node?) {
            guard let node = node else { return  }
            ans.append(node.val)
            for child in node.children {
                _preorder(child)
            }
        }
        _preorder(root)
        return ans
    }

    func preorder(_ root: Node?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [root]
        while !stack.isEmpty {
            let top = stack.removeLast()
            ans.append(top.val)
            for child in top.children.reversed() {
                stack.append(child)
            }
        }
        return ans
    }
}
// @lc code=end


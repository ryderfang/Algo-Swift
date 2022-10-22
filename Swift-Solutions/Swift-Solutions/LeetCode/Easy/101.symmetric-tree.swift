/*
 * @lc app=leetcode id=101 lang=swift
 *
 * [101] Symmetric Tree
 */

// @lc code=start
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
extension Solution {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        func _isSame(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
            if left?.val != right?.val {
                return false
            }
            if left == nil && right == nil {
                return true
            }
            return _isSame(left?.left, right?.right) && _isSame(left?.right, right?.left)
        }

        guard let root = root else { return true }
        if root.left?.val != root.right?.val {
            return false
        }
        return _isSame(root.left, root.right)
    }

    func isSymmetric1(_ root: TreeNode?) -> Bool {
        var ans = true
        // check each level
        func _isSymmetric(_ nodes: [TreeNode?]) -> (Bool, [TreeNode?]) {
            guard !nodes.isEmpty else { return (true, []) }
            var next: [TreeNode?] = []
            var check = true
            let revNodes: [TreeNode?] = nodes.reversed()
            for i in 0..<nodes.count {
                if let node = nodes[i] {
                    next.append(contentsOf: [node.left, node.right])
                }
                if check == true && nodes[i]?.val != revNodes[i]?.val {
                    check = false
                }
            }
            return (check, next)
        }
        var queue: [TreeNode?] = [root]
        while !queue.isEmpty && ans {
            let tmp = _isSymmetric(queue)
            ans = tmp.0
            queue = tmp.1
        }
        return ans
    }
}
// @lc code=end


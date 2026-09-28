/*
 * @lc app=leetcode id=235 lang=swift
 *
 * [235] Lowest Common Ancestor of a Binary Search Tree
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

extension Solution {
    // BST_LCA 最近公共祖先问题 (平衡树版)
    func lowestCommonAncestor1_1(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var path1 = [TreeNode]()
        var path2 = [TreeNode]()
        func _search(_ root: TreeNode?, _ t: TreeNode?, _ path: inout [TreeNode]) {
            guard let root = root, let t = t else { return }
            if root.val == t.val {
                path.append(t)
                return
            }
            path.append(root)
            if root.val < t.val {
                _search(root.right, t, &path)
            } else {
                _search(root.left, t, &path)
            }
        }
        _search(root, p, &path1)
        _search(root, q, &path2)
        let st2 = Set<Int>(path2.map { $0.val })
        for nd in path1.reversed() {
            if st2.contains(nd.val) {
                return nd
            }
        }
        return nil
    }

    func lowestCommonAncestor1(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else { return nil }
        switch (p: p.val, q: q.val) {
        case let val where root.val > val.p && root.val > val.q:
            return lowestCommonAncestor(root.left, p, q)
        case let val where root.val < val.p && root.val < val.q:
            return lowestCommonAncestor(root.right, p, q)
        default:
            return root
        }
    }
}
// @lc code=end


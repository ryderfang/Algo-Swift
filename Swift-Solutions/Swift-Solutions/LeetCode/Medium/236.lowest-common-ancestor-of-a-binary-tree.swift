/*
 * @lc app=leetcode id=236 lang=swift
 *
 * [236] Lowest Common Ancestor of a Binary Tree
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
    // LCA 最近公共祖先问题 (二叉树版)
    // 暴力算法 O(nq)
    func lowestCommonAncestor2_1(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else { return nil }
        if root.val == p.val || root.val == q.val { return root }
        let left = lowestCommonAncestor2_1(root.left, p, q)
        let right = lowestCommonAncestor2_1(root.right, p, q)
        if left != nil && right != nil {
            return root
        }
        if left != nil {
            return left
        }
        return right
    }

    // Tarjan 离线算法 (dfs + union find)
    // O(n+q)
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else { return nil }
        let query = [p.val: [q.val], q.val: [p.val]]
        let ufd = UnionFind()
        var mp = [Int: TreeNode]()
        var visit = Set<Int>()
        var ans: TreeNode? = nil
        func _tarjan(_ node: TreeNode?)  {
            guard ans == nil else { return }
            guard let node = node else { return }
            mp[node.val] = node
            if let left = node.left {
                _tarjan(left)
                ufd.merge(left.val, node.val)
            }
            if let right = node.right {
                _tarjan(right)
                ufd.merge(right.val, node.val)
            }
            visit.insert(node.val)
            for v in query[node.val, default: []] {
                if visit.contains(v) {
                    ans = mp[ufd.find(v)]
                    return
                }
            }
        }
        _tarjan(root)
        return ans
    }

    // TODO: RMQ + ST 算法 (在线)
    // O(nlog2n + q)
    // - RMQ: Range Minimum Query
    // - ST: Sparse Table 稀疏表

    // TODO: 倍增法
    // O((n+q)log2n)
}


fileprivate class UnionFind {
    private var parent: [Int: Int]

    init() {
        parent = [Int: Int]()
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x] ?? x)
        }
        return parent[x, default: x]
    }

    func merge(_ x: Int, _ y: Int) {
        if parent[x] == nil { parent[x] = x }
        if parent[y] == nil { parent[y] = y }
        parent[find(x)] = find(y)
    }
}
// @lc code=end

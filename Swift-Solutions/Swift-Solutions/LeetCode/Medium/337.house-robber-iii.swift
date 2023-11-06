/*
 * @lc app=leetcode id=337 lang=swift
 *
 * [337] House Robber III
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
    func rob(_ root: TreeNode?) -> Int {
        var mp = [ObjectIdentifier: Int]()
        func _solve(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            var ret = mp[ObjectIdentifier(node), default: -1]
            guard ret == -1 else { return ret }
            let grandChilds = [node.left?.left, node.left?.right, node.right?.left, node.right?.right].compactMap({ $0 })
            var ans = node.val
            for gc in grandChilds {
                ans += _solve(gc)
            }
            ret = max(ans, _solve(node.left) + _solve(node.right))
            mp[ObjectIdentifier(node)] = ret
            return ret
        }
        return _solve(root)
    }

    // Better solution: now - child, last - grandChild
    func rob33(_ root: TreeNode?) -> Int {
        func helper(_ node: TreeNode) -> (now: Int, last: Int) {
            let (lnow, llast) = node.left != nil ? helper(node.left!) : (0, 0)
            let (rnow, rlast) = node.right != nil ? helper(node.right!) : (0, 0)
            return (max(lnow + rnow, llast + rlast + node.val), lnow + rnow)
        }
        return root != nil ? helper(root!).now : 0
    }
}
// @lc code=end

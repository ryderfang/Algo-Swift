/*
 * @lc app=leetcode id=99 lang=swift
 *
 * [99] Recover Binary Search Tree
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a binary tree node.
 * public extension TreeNode {
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
    func recoverTree(_ root: TreeNode?) {
        var first: TreeNode? = nil
        var second: TreeNode? = nil
        var pre: TreeNode = TreeNode(Int.min)

        func _inorder(_ node: TreeNode?) {
            guard let node = node else { return }
            _inorder(node.left)

            if first == nil && pre.val >= node.val { first = pre }
            if first != nil && pre.val >= node.val { second = node }
            pre = node

            _inorder(node.right)
        }
        _inorder(root)
        guard let first = first, let second = second else { return }
        swap(&first.val, &second.val)
    }


    // 前提：不改变结构，仅交换一次；
    // 中序遍历过程中，找前一个比前后大，后一个比前后小，它们交换即可。
    func recoverTree1(_ root: TreeNode?) {
        var ans = [TreeNode]()
        var stack = [TreeNode]()
        var node = root
        var first: TreeNode? = nil
        var second: TreeNode? = nil
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node!)
                node = node?.left
            }
            let top = stack.popLast()
            ans.append(top!)
            let count = ans.count
            if count > 1 {
                if ans[count-1].val < ans[count-2].val {
                    first = first == nil ? ans[count-2] : first
                    second = ans[count-1]
                }
            }
            if count > 2 {
                if ans[count-1].val < ans[count-2].val && ans[count-2].val > ans[count-3].val {
                    first = first == nil ? ans[count-2] : first
                }
                if ans[count-1].val > ans[count-2].val && ans[count-2].val < ans[count-3].val {
                    second = ans[count-2]
                }
            }
            node = top!.right
        }

        if let first = first, let second = second {
            swap(&first.val, &second.val)
        }
    }
}
// @lc code=end


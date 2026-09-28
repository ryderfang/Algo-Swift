/*
 * @lc app=leetcode id=145 lang=swift
 *
 * [145] Binary Tree Postorder Traversal
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
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var stack = [TreeNode]()
        var node = root
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node!)
                ans.insert(node!.val, at: 0)
                node = node?.right
            }
            let top = stack.popLast()
            node = top!.left
        }
        return ans
    }

    func postorderTraversal1(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var stack = [TreeNode]()
        var node = root
        var lastNode: TreeNode? = nil
        while !stack.isEmpty || node != nil {
            if node != nil {
                stack.append(node!)
                node = node?.left
            } else {
                let top = stack.last!
                if top.right != nil && lastNode != top.right {
                    node = top.right
                } else {
                    ans.append(top.val)
                    lastNode = stack.popLast()
                }
            }
        }
        return ans
    }

    // MARK: Recursive
    func postorderTraversal2(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        func _postorder(_ node: TreeNode?, _ res: inout [Int]) {
            guard let node = node else { return }
            _postorder(node.left, &res)
            _postorder(node.right, &res)
            res.append(node.val)
        }
        _postorder(root, &ans)
        return ans
    }
}

extension TreeNode: @retroactive Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val && lhs.left == rhs.left && lhs.right == rhs.right
    }
}

// @lc code=end

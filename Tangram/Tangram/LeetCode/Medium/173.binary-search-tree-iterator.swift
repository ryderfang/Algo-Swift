/*
 * @lc app=leetcode id=173 lang=swift
 *
 * [173] Binary Search Tree Iterator
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

class BSTIterator {
    var stack: [TreeNode]

    init(_ root: TreeNode?) {
        stack = [TreeNode]()
        appendNodes(root)
    }
    
    func next() -> Int {
        if let top = stack.popLast() {
            appendNodes(top.right)
            return top.val
        }
        return -1
    }
    
    func hasNext() -> Bool {
        return !stack.isEmpty
    }

    private func appendNodes(_ node: TreeNode?) {
        var node = node
        while let tmp = node {
            stack.append(tmp)
            node = node?.left
        }
    }
}

/**
 * Your BSTIterator object will be instantiated and called as such:
 * let obj = BSTIterator(root)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
// @lc code=end


/*
 * @lc app=leetcode id=1372 lang=swift
 *
 * [1372] Longest ZigZag Path in a Binary Tree
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
    // Better solution: DFS
    func longestZigZag(_ root: TreeNode?) -> Int {
        var maxSteps = 0
        func _dfs(_ node: TreeNode?, _ isLeft: Bool, _ steps: Int) {
            guard let node = node else { return }
            maxSteps = max(maxSteps, steps)
            if isLeft {
                _dfs(node.left, false, steps + 1)
                _dfs(node.right, true, 1)
            } else {
                _dfs(node.right, true, steps + 1)
                _dfs(node.left, false, 1)
            }
        }
        _dfs(root?.right, true, 1)
        _dfs(root?.left, false, 1)
        return maxSteps
    }

    //
    func longestZigZag1(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var left = [ObjectIdentifier: Int]()
        var right = [ObjectIdentifier: Int]()
        func _solve(_ node: TreeNode?, _ moveLeft: Bool) -> Int {
            guard let node = node else { return 0 }
            if moveLeft, let ans = left[ObjectIdentifier(node)] {
                return ans
            }
            if !moveLeft, let ans = right[ObjectIdentifier(node)] {
                return ans
            }
            if moveLeft {
                left[ObjectIdentifier(node)] = _solve(node.left, !moveLeft) + (node.left != nil ? 1 : 0)
                return left[ObjectIdentifier(node), default: 0]
            } else  {
                right[ObjectIdentifier(node)] = _solve(node.right, !moveLeft) + (node.right != nil ? 1 : 0)
                return right[ObjectIdentifier(node), default: 0]
            }
        }
        var ret = 0
        var stack = [root]
        while !stack.isEmpty {
            let top = stack.removeLast()
            ret = max(ret, _solve(top, true))
            ret = max(ret, _solve(top, false))
            stack.append(contentsOf: [top.right, top.left].compactMap { $0 })
        }
        return ret
    }
}
// @lc code=end


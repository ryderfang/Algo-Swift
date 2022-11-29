/*
 * @lc app=leetcode id=95 lang=swift
 *
 * [95] Unique Binary Search Trees II
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
    func generateTrees(_ n: Int) -> [TreeNode?] {
        guard n > 1 else { return [TreeNode(1)] }
        func _subTrees(_ v: [Int]) -> [TreeNode?] {
            guard v.count > 0 else { return [nil] }
            var ans = [TreeNode?]()
            for x in v {
                ans.append(contentsOf: _generate(x, v))
            }
            return ans
        }

        func _generate(_ root: Int, _ v: [Int]) -> [TreeNode?] {
            let left = v.filter { $0 < root }
            let right = v.filter { $0 > root }
            let leftTrees = _subTrees(left)
            let rightNodes = _subTrees(right)
            var ans = [TreeNode?]()
            for x in leftTrees {
                for y in rightNodes {
                    let tmp = TreeNode(root)
                    tmp.left = x
                    tmp.right = y
                    ans.append(tmp)
                }
            }
            return ans
        }
        var ans = [TreeNode?]()
        for i in 1...n {
            ans.append(contentsOf: _generate(i, [Int](1...n)))
        }
        return ans
    }
}
// @lc code=end


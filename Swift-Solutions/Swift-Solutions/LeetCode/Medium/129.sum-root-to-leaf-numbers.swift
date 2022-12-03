/*
 * @lc app=leetcode id=129 lang=swift
 *
 * [129] Sum Root to Leaf Numbers
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
    func sumNumbers(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var ans = 0
        func _sum(_ root: TreeNode?, _ path: [Int], ans: inout Int) {
            guard let node = root else { return }
            let path = path + [node.val]
            if node.left == nil && node.right == nil {
                var tmp = 0
                for x in path {
                    tmp = tmp * 10 + x
                }
                ans += tmp
            }
            _sum(node.left, path, ans: &ans)
            _sum(node.right, path, ans: &ans)
        }
        _sum(root, [], ans: &ans)
        return ans
    }
}
// @lc code=end


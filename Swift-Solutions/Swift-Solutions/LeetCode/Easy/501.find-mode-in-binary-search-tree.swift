/*
 * @lc app=leetcode id=501 lang=swift
 *
 * [501] Find Mode in Binary Search Tree
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
    // mode - 众数
    func findMode(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        func _sequence(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            return _sequence(node.left) + [node.val] + _sequence(node.right)
        }
        let seq = _sequence(root)
        var pre: Int = seq.first!
        var maxCnt = 0, cnt = 1
        var ans = [Int]()
        for x in seq.dropFirst() {
            if x == pre {
                cnt += 1
            } else {
                if cnt > maxCnt {
                    ans.removeAll()
                }
                if cnt >= maxCnt {
                    ans.append(pre)
                }
                maxCnt = max(maxCnt, cnt)
                cnt = 1
                pre = x
            }
        }
        if cnt > maxCnt {
            ans.removeAll()
        }
        if cnt >= maxCnt {
            ans.append(pre)
        }
        maxCnt = max(maxCnt, cnt)
        print(maxCnt)
        return ans
    }
}
// @lc code=end


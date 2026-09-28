/*
 * @lc app=leetcode id=637 lang=swift
 *
 * [637] Average of Levels in Binary Tree
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
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        var level = [TreeNode?]()
        level.append(root)
        var ans = [Double]()
        while !level.isEmpty {
            let nodes = level.compactMap({ $0 })
            guard nodes.count > 0 else { break }
            ans.append((nodes.map { Double($0.val) }.reduce(0, +) / Double(nodes.count)).truncate(places: 5))
            level = nodes.flatMap { [$0.left, $0.right] }
        }
        return ans
    }
}

fileprivate extension Double {
    // 截断
    func truncate(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        print(String(format: "%.\(places)f", self))
        return Double(Int(self * divisor)) / divisor
    }
}

// @lc code=end


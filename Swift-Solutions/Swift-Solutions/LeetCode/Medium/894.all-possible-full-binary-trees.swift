/*
 * @lc app=leetcode id=894 lang=swift
 *
 * [894] All Possible Full Binary Trees
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
    // Better solution
    func allPossibleFBT(_ n: Int) -> [TreeNode?] {
        var mp = [Int: [TreeNode]]()
        func _solve(_ n: Int) -> [TreeNode] {
            guard n % 2 == 1 else { return [] }
            if let found = mp[n] {
                return found
            }
            var ans = [TreeNode]()
            if n == 1 {
                ans.append(TreeNode(0))
            }
            for i in stride(from: 1, to: n, by: 2) {
                let leftSubTree = _solve(i)
                let rightSubTree = _solve(n - i - 1)
                for l in leftSubTree {
                    for r in rightSubTree {
                        let root = TreeNode(0)
                        root.left = l
                        root.right = r
                        ans.append(root)
                    }
                }
            }
            mp[n] = ans
            return ans
        }
        return _solve(n)
    }

    // 满二叉树
    func allPossibleFBT1(_ n: Int) -> [TreeNode?] {
        guard n % 2 == 1 else { return [] }
        var ans = [TreeNode(0)]
        var i = 1
        while i < n {
            var tmp = [TreeNode]()
            var mp = Set<String>()
            for x in ans {
                for leaf in x.leafs() {
                    leaf.left = TreeNode(0)
                    leaf.right = TreeNode(0)
                    let copied = x.copy()
                    let hash = copied.hash()
                    if !mp.contains(hash) {
                        mp.insert(hash)
                        tmp.append(copied)
                    }
                    // reverted
                    leaf.left = nil
                    leaf.right = nil
                }
            }
            ans = tmp
            i += 2
        }
        // debug
        for t in ans {
            print(t.hash())
        }
        return ans
    }
}

fileprivate extension TreeNode {
    func leafs() -> [TreeNode] {
        var ans = [TreeNode]()
        if left == nil && right == nil {
            ans.append(self)
        } else {
            ans.append(contentsOf: left?.leafs() ?? [])
            ans.append(contentsOf: right?.leafs() ?? [])
        }
        return ans
    }

    func copy() -> TreeNode {
        let node = TreeNode(val)
        node.left = left?.copy()
        node.right = right?.copy()
        return node
    }

    func hash() -> String {
        var ans: [Int?] = []
        var queue: [TreeNode?] = [self]
        while !queue.isEmpty {
            guard let node = queue.removeFirst() else {
                ans.append(nil)
                continue
            }
            ans.append(node.val)
            queue.append(node.left)
            queue.append(node.right)
        }
        // remove nils at last
        while let last = ans.last, last == nil {
            ans.removeLast()
        }
        return ans.map {
            if let x = $0 { return String(x) }
            else { return "null" }
        }.joined(separator: ",")
    }
}

// @lc code=end

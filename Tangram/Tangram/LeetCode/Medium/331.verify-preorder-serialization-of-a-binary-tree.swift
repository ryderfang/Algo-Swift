/*
 * @lc app=leetcode id=331 lang=swift
 *
 * [331] Verify Preorder Serialization of a Binary Tree
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isValidSerialization(_ preorder: String) -> Bool {
        class Node {
            var num: Character
            var left: Bool
            var right: Bool
            init(_ num: Character, _ left: Bool = true, _ right: Bool = true) {
                self.num = num
                self.left = left
                self.right = right
            }
        }
        let pre: [Character] = preorder.split(separator: ",").compactMap { $0.first }
        let n = pre.count
        // "#" -> empty tree
        guard n > 0 && pre[0] != "#" else { return n == 1 }
        var ans = [Node]()
        ans.append(Node(pre[0]))
        var i = 1
        while i < n && !ans.isEmpty {
            if pre[i] == "#" {
                while true {
                    guard let last = ans.last else { break }
                    if last.left {
                        ans.last?.left = false
                        break
                    }
                    if last.right {
                        ans.last?.right = false
                        ans.removeLast()
                    }
                }
            } else {
                ans.append(Node(pre[i]))
            }
            i += 1
        }
        if ans.isEmpty && i == n {
            return true
        }
        return false
    }
}
// @lc code=end


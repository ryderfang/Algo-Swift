/*
 * @lc app=leetcode id=138 lang=swift
 *
 * [138] Copy List with Random Pointer
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var next: Node?
 *     public var random: Node?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *    	   self.random = nil
 *     }
 * }
 */

extension Solution {
    func copyRandomList(_ head: Node?) -> Node? {
        guard let head = head else { return nil }
        var p: Node? = head
        var cloneMap = [ObjectIdentifier: Node]()
        let ans = _getClonedNode(head)
        func _getClonedNode(_ obj: Node) -> Node {
            let objAddr = ObjectIdentifier(obj)
            if cloneMap[objAddr] == nil {
                cloneMap[objAddr] = Node(obj.val)
            }
            return cloneMap[objAddr]!
        }
        while p != nil {
            guard let old = p else { break }
            let new = _getClonedNode(old)
            if let next = old.next {
                new.next = _getClonedNode(next)
            }
            if let random = old.random {
                new.random = _getClonedNode(random)
            }
            p = p?.next
        }
        return ans
    }
}

// @lc code=end


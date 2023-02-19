/*
 * @lc app=leetcode id=208 lang=swift
 *
 * [208] Implement Trie (Prefix Tree)
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class Trie {
    // 不能用 struct，否则赋值时是 copy，无法修改原来的值
    class Node {
        var child = [Node?](repeating: nil, count: 26)
        var isLeaf = false
    }

    private var root: Node

    init() {
        root = Node()
    }
    
    func insert(_ word: String) {
        var node = root
        for ch in word {
            let index = Int(ch.asciiValue! - 97)
            if let child = node.child[index] {
                node = child
            } else {
                let newNode = Node()
                node.child[index] = newNode
                node = newNode
            }
        }
        node.isLeaf = true
    }
    
    func search(_ word: String) -> Bool {
        var node = root
        for ch in word {
            let index = Int(ch.asciiValue! - 97)
            if let child = node.child[index] {
                node = child
            } else {
                return false
            }
        }
        return node.isLeaf
    }
    
    func startsWith(_ prefix: String) -> Bool {
        var node = root
        for ch in prefix {
            let index = Int(ch.asciiValue! - 97)
            if let child = node.child[index] {
                node = child
            } else {
                return false
            }
        }
        return true
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * let obj = Trie()
 * obj.insert(word)
 * let ret_2: Bool = obj.search(word)
 * let ret_3: Bool = obj.startsWith(prefix)
 */
// @lc code=end


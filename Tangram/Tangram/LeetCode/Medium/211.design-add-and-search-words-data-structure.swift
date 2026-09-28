/*
 * @lc app=leetcode id=211 lang=swift
 *
 * [211] Design Add and Search Words Data Structure
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class WordDictionary {
    private var tree = _Trie()

    init() {
    }
    
    func addWord(_ word: String) {
        tree.insert(word)
    }

    
    func search(_ word: String) -> Bool {
        return tree._search(tree.root, 0, Array(word))
    }
}

private extension _Trie {
    func _search(_ node: Node, _ i: Int, _ arr: [Character]) -> Bool {
        guard i < arr.count else {
            return node.end
        }
        let ch = arr[i]
        if ch == "." {
            for x in 0..<26 {
                guard let child = node.child[x] else { continue }
                if _search(child, i + 1, arr) {
                    return true
                }
            }
        } else {
            let index = Int(ch.asciiValue! - 97)
            if let child = node.child[index] {
                if _search(child, i + 1, arr) {
                    return true
                }
            }
        }
        return false
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */

fileprivate class _Trie {
    class Node {
        var child = [Node?](repeating: nil, count: 26)
        var end = false
    }

    public var root = Node()

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
        node.end = true
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
        return node.end
    }
}

// @lc code=end

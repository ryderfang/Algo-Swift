//
//  Trie.swift
//  AlgoBase
//
//  Created by ryfang on 2023/2/19.
//

import Foundation

fileprivate class Trie {
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

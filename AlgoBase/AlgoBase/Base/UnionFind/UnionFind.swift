//
//  UnionFind.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/4.
//

import Foundation

// 带路径压缩的并查集
// - 用于动态维护查询等价类
// - 用于图论中动态差点集连通
// 维护和查询复杂度略大于 O(1)
class UnionFind {
    private var parent: [Int]
    private var rank: [Int]

    init(_ n: Int) {
        parent = [Int](repeating: 0, count: n + 1)
        rank = [Int](repeating: 1, count: n + 1)
        for x in parent {
            parent[x] = x
        }
    }

    public func setFriend(_ i: Int, _ j: Int) {
        merge(i, j)
    }

    public func isFriend(_ i: Int, _ j: Int) -> Bool {
        return find(i) == find(j)
    }
}

private extension UnionFind {
    func find(_ x: Int) -> Int {
        if parent[x] == x {
            return x
        } else {
            parent[x] = find(parent[x])
            return parent[x]
        }
    }

    func merge(_ i: Int, _ j: Int) {
        let x = min(i, j)
        let y = max(i, j)
        parent[find(x)] = find(y)
    }
}

private extension UnionFind {
    func _find(_ x: Int) -> Int {
        if parent[x] == x {
            return x
        } else {
            parent[x] = _find(parent[x])
            return parent[x]
        }
    }

    func _merge(_ i: Int, _ j: Int) {
        let parent_i = _find(i)
        let parent_j = _find(j)
        guard parent_i != parent_j else { return }
        if rank[parent_i] > rank[parent_j] {
            parent[parent_j] = parent_i
        } else if parent[parent_i] < parent[parent_j] {
            parent[parent_i] = parent_j
        } else {
            parent[parent_j] = parent_i
            rank[parent_i] += 1
        }
    }
}

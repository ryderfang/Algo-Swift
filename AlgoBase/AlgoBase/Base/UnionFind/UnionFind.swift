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
fileprivate class UnionFind {
    private var parent: [Int]
    private var rank: [Int]

    init(_ n: Int, withRank: Bool = false ) {
        parent = Array(0...n)
        rank = [Int]()
        if withRank {
            rank = [Int](repeating: 0, count: n + 1)
        }
    }

    public func setFriend(_ x: Int, _ y: Int) {
        merge(x, y)
    }

    public func isFriend(_ x: Int, _ y: Int) -> Bool {
        return find(x) == find(y)
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

    func merge(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}

private extension UnionFind {
    func _merge(_ x: Int, _ y: Int) {
        let px = find(x), py = find(y)
        if rank[px] > rank[py] {
            parent[py] = px
        } else {
            parent[px] = py
            rank[py] += (rank[px] == rank[py] ? 1 : 0)
        }
    }
}

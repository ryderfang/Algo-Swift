//
//  UnionFind.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/4.
//

import Foundation

fileprivate class UnionFind {
    private var parent: [Int: Int]

    init() {
        parent = [Int: Int]()
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x] ?? x)
        }
        return parent[x, default: x]
    }

    func merge(_ x: Int, _ y: Int) {
        if parent[x] == nil { parent[x] = x }
        if parent[y] == nil { parent[y] = y }
        parent[find(x)] = find(y)
    }
}

// 带路径压缩的并查集
// - 用于动态维护查询等价类
// - 用于图论中动态差点集连通
// 维护和查询复杂度略大于 O(1)
fileprivate class UnionFind2 {
    private var parent: [Int]
    private var rank: [Int]

    init(_ n: Int) {
        parent = Array(0...n)
        rank = [Int](repeating: 0, count: n + 1)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func merge(_ x: Int, _ y: Int) {
        let px = find(x), py = find(y)
        if rank[px] > rank[py] {
            parent[py] = px
        } else {
            parent[px] = py
            rank[py] += (rank[px] == rank[py] ? 1 : 0)
        }
    }
}

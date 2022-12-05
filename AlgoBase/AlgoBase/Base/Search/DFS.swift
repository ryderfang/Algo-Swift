//
//  DFS.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/5.
//

import Foundation

extension Search {
    public static func dfs(_ v: Int, _ visited: inout [Int], _ path: [Int: [Int]]) {
        print(v)
        visited[v] = 1
        for x in path[v, default: []] {
            guard visited[x] == 0 else { continue }
            dfs(x, &visited, path)
        }
    }

    public static func connectedGraph(_ path: [Int: [Int]]) -> Set<Int> {
        var graph = Set<Int>()
        func _dfs(_ v: Int) {
            graph.insert(v)
            for x in path[v, default: []] {
                guard !graph.contains(x) else { continue }
                _dfs(x)
            }
        }
        if let start = path.first {
            _dfs(start.key)
        }
        return graph
    }
}

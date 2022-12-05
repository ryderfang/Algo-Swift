//
//  BFS.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/5.
//

import Foundation

extension Search {
    public static func bfs(_ nodes: [Int], _ depth: Int, _ visited: inout [Int], _ path: [Int: [Int]]) {
        print("#\(depth)# \(nodes)")
        for x in nodes {
            visited[x] = 1
        }
        let next = nodes.flatMap { path[$0, default: []] }.filter { visited[$0] == 0 }
        guard next.count > 0 else { return }
        bfs(next, depth + 1, &visited, path)
    }
}

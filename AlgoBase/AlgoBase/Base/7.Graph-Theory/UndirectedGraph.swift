//
//  UndirectedGraph.swift
//  AlgoBase
//
//  Created by ryfang on 2023/2/12.
//

import Foundation

// 无向图
class UndirectedGraph {
    // To be tested.
    public static func hasCircle(_ num: Int, _ edges: [[Int]]) -> Bool {
        guard edges.count > 0 else { return true }
        var graph = [[Int]](repeating: [Int](repeating: 0, count: num), count: num)
        for p in edges {
            graph[p[0]][p[1]] = 1
            graph[p[1]][p[0]] = 1
        }
        enum State: Int {
            case unvisited = 0
            case visiting = 1
            case visited = 2
        }
        var state = [State](repeating: .unvisited, count: num)
        func dfs(_ u: Int) -> Bool {
            state[u] = .visiting
            for v in 0..<num {
                guard graph[u][v] == 1 else { continue }
                guard state[v] != .visiting else {
                    return false
                }
                if state[v] == .unvisited {
                    if !dfs(v) {
                        return false
                    }
                }
            }
            state[u] = .visited
            return true
        }
        for i in 0..<num {
            if state[i] == .unvisited {
                if !dfs(i) {
                    return false
                }
            }
        }
        return true
    }

    // Floyd-Warshall 算法，求无向图中任意两点之间的最短距离
    public static func minDistance(_ n: Int, _ edges: [[Int]]) {
        var dist: [[Int]] = (0..<n).map { row in
            (0..<n).map { col in
                row == col ? 0 : Int.max
            }
        }

        for edge in edges {
            let (u, v, distance) = (edge[0], edge[1], edge[2])
            dist[u][v] = distance
            dist[v][u] = distance
        }

        // k should outer-most
        for k in 0..<n {
            for i in 0..<n {
                for j in 0..<n {
                    guard dp[i][k] < Int.max && dp[k][j] < Int.max else { continue }
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
                }
            }
        }
    }
}

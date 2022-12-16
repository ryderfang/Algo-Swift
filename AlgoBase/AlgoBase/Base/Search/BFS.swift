//
//  BFS.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/5.
//

import Foundation

extension Search {
    // 递归
    public static func bfs(_ nodes: [Int], _ depth: Int, _ visited: inout [Int], _ path: [Int: [Int]]) {
        print("#\(depth)# \(nodes)")
        var next = [Int]()
        for x in nodes {
            visited[x] = 1
            for neighbor in path[x, default: []] {
                guard visited[neighbor] == 0 else { continue }
                visited[neighbor] = 1
                next.append(neighbor)
            }
        }
        guard next.count > 0 else { return }
        bfs(next, depth + 1, &visited, path)
    }

    // 非递归 (队列）
    public static func bfs(start: Int, n: Int, _ path: [Int: [Int]]) {
        var visited = Set<Int>()
        visited.insert(start)
        var queue: [Int] = [start]
        var output = [Int]()
        while !queue.isEmpty {
            let top = queue.removeFirst()
            output.append(top)
            for neighbor in path[top, default: []] {
                guard !visited.contains(neighbor) else { continue }
                visited.insert(neighbor)
                queue.append(neighbor)
            }
        }
        print(output)
    }
}

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
            guard visited[x] == 0 else { continue }
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
    public static func bfs(start: Int, _ path: [Int: [Int]]) {
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

    // bfs - Query (start -> end)
    public static func bfsQuery(start: Int, end: Int, _ path: [Int: [Int]]) -> Bool {
        guard start != end else { return true }
        var visited = Set([start])
        var queue: [Int] = [start]
        while !queue.isEmpty {
            let top = queue.removeFirst()
            for neighbor in path[top, default: []] where !visited.contains(neighbor) {
                guard neighbor != end else { return true }
                queue.append(neighbor)
                visited.insert(neighbor)
            }
        }
        return false
    }
}

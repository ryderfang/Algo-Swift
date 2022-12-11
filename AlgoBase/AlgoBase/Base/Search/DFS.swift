//
//  DFS.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/5.
//

import Foundation

// DFS 与 BFS 非递归实现唯一区别是：
// 栈 <-> 队列
// removeLast <-> removeFirst
extension Search {
    // 递归
    public static func dfs(_ v: Int, _ visited: inout [Int], _ path: [Int: [Int]], _ out: inout [Int]) {
        out.append(v)
        visited[v] = 1
        for x in path[v, default: []] {
            guard visited[x] == 0 else { continue }
            dfs(x, &visited, path, &out)
        }
    }

    // 非递归
    public static func dfs(start: Int, n: Int, _ path: [Int: [Int]]) {
        var visited = Set<Int>()
        visited.insert(start)
        var stack: [Int] = [start]
        var output = [Int]()
        while !stack.isEmpty {
            let last = stack.removeLast()
            output.append(last)
            for neighbor in path[last, default: []] {
                guard !visited.contains(neighbor) else { continue }
                visited.insert(neighbor)
                stack.append(neighbor)
            }
        }
        print(output)
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

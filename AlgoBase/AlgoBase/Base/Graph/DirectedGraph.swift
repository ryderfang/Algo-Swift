//
//  DirectedGraph.swift
//  AlgoBase
//
//  Created by ryfang on 2023/2/12.
//

import Foundation

// 有向图
class DirectedGraph {
    // lc207
    public static func hasCircle(_ num: Int, _ edges: [[Int]]) -> Bool {
        guard edges.count > 0 else { return true }
        var inDegree = [Int](repeating: 0, count: num)
        var graph = [[Int]](repeating: [Int](), count: num)
        for p in edges {
            graph[p[0]].append(p[1])
            inDegree[p[1]] += 1
        }
        // 循环：输出入度为 0 的顶点，并删除它及其起始的边；
        // 能输出所有顶点则无环
        var topoSort = [Int]()
        while let idx = inDegree.firstIndex(where: { $0 == 0 }) {
            topoSort.append(idx)
            inDegree[idx] = -1
            for v in graph[idx] {
                inDegree[v] -= 1
            }
        }
        print(topoSort)
        return topoSort.count == num
    }
}

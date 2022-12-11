//
//  SearchTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2022/12/5.
//

import XCTest
@testable import AlgoBase

final class SearchTests: XCTestCase {
    private var n: Int = 0
    private var edges = [[Int]]()
    private var path = [Int: [Int]]()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        n = 26
        edges = [[9,16],[8,3],[20,21],[12,16],[14,3],[7,21],[22,3],[22,18],[11,16],[25,4],[2,4],[14,21],[23,3],[17,3],[2,16],[24,16],[13,4],[10,21],[7,4],[9,18],[14,18],[14,4],[14,16],[1,3],[25,18],[17,4],[1,16],[23,4],[2,21],[5,16],[24,18],[20,18],[19,16],[24,21],[9,3],[24,3],[19,18],[25,16],[19,21],[6,3],[26,18],[5,21],[20,16],[2,3],[10,18],[26,16],[8,4],[11,21],[23,16],[13,16],[25,3],[7,18],[19,3],[20,4],[26,3],[23,18],[15,18],[17,18],[10,16],[26,21],[23,21],[7,16],[8,18],[10,4],[24,4],[7,3],[11,18],[9,4],[26,4],[13,21],[22,16],[22,21],[20,3],[6,18],[9,21],[10,3],[22,4],[1,18],[25,21],[11,4],[1,21],[15,3],[1,4],[15,16],[2,18],[13,3],[8,21],[13,18],[11,3],[15,21],[8,16],[17,16],[15,4],[12,3],[6,4],[17,21],[5,18],[6,16],[6,21],[12,4],[19,4],[5,3],[12,21],[5,4]]
        for edge in edges {
            path[edge[0], default: []].append(edge[1])
            path[edge[1], default: []].append(edge[0])
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBFS() {
        var visited = [Int](repeating: 0, count: n + 1)
        Search.bfs([1], 1, &visited, path)
    }

    func testBFS2() {
        Search.bfs(start: 1, n: n, path)
    }

    func testDFS() {
        var visited = [Int](repeating: 0, count: n + 1)
        var output = [Int]()
        Search.dfs(1, &visited, path, &output)
        print(output)
    }

    func testDFS2() {
        Search.dfs(start: 1, n: n, path)
    }

    func testConnected() {
        let graph = Search.connectedGraph(path)
        print(graph)
    }
}

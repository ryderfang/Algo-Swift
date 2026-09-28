/*
 * @lc app=leetcode id=130 lang=swift
 *
 * [130] Surrounded Regions
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func solve(_ board: inout [[Character]]) {
        let m = board.count
        let n = board[0].count
        guard m > 1 && n > 1 else { return }
        typealias Point = (Int, Int)
        let union = UnionFind(m * n)
        func _isFriend(_ p1: Point, _ p2: Point) -> Bool {
            return union.isFriend(p1.0 * n + p1.1 + 1, p2.0 * n + p2.1 + 1)
        }
        func _setFriend(_ p1: Point, _ p2: Point) {
            union.setFriend(p1.0 * n + p1.1 + 1, p2.0 * n + p2.1 + 1)
        }
        var visit = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                guard board[i][j] == Character("O") else { continue }
                visit[i][j] = true
                // 4 directions
                if i > 0 && board[i-1][j] == Character("O") && !visit[i-1][j] {
                    _setFriend((i, j), (i-1, j))
                }
                if j > 0 && board[i][j-1] == Character("O") && !visit[i][j-1] {
                    _setFriend((i, j), (i, j-1))
                }
                if i < m - 1 && board[i+1][j] == Character("O") && !visit[i+1][j] {
                    _setFriend((i, j), (i+1, j))
                }
                if j < n - 1 && board[i][j+1] == Character("O") && !visit[i][j+1] {
                    _setFriend((i, j), (i, j+1))
                }
                // on border
                if i == 0 || j == 0 || i == m - 1 || j == n - 1 {
                    _setFriend((i, j), (0, -1))
                }
            }
        }

        for i in 0..<m {
            for j in 0..<n {
                guard board[i][j] == Character("O") else { continue }
                if !_isFriend((i, j), (0, -1)) {
                    board[i][j] = Character("X")
                }
            }
        }
    }
}

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
// @lc code=end

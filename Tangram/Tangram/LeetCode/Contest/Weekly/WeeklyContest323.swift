//
//  WeeklyContest.swift
//  Titan
//
//  Created by ryfang on 2022/11/26.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func deleteGreatestValue(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        let grid = grid.map { $0.sorted() }
        var ans = 0
        for j in 0..<n {
            var tmp = 0
            for i in 0..<m {
                tmp = max(tmp, grid[i][j])
            }
            ans += tmp
        }
        return ans
    }

    func longestSquareStreak(_ nums: [Int]) -> Int {
        // 317 ^ 2 > 100000
        let n = 317
        var mp = [Int: Int]()
        for x in nums {
            mp[x, default: 0] += 1
        }
        var ans = -1
        for i in 2..<n {
            var tmp = 0
            var j = i
            while mp[j, default: 0] > 0 {
                tmp += 1
                j = j * j
            }
            if tmp > 1 {
                ans = max(ans, tmp)
            }
        }
        return ans
    }

    func maxPoints(_ grid: [[Int]], _ queries: [Int]) -> [Int] {
        let m = grid.count
        let n = grid[0].count
        var sorted = [(Int, Int, Int)]()
        for (i, q) in queries.enumerated() {
            sorted.append((i, q, 0))
        }
        sorted = sorted.sorted(by: { $0.1 < $1.1 })

        var visited = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        var queue: [(Int, Int, Int)] = [(0, 0, grid[0][0])]
        func _bfs(_ target: Int, _ result: inout Int) {
            while !queue.isEmpty {
                guard let idx = queue.firstIndex(where: { $0.2 < target }) else { return }
                let r = queue[idx].0
                let c = queue[idx].1
                queue.remove(at: idx)
                visited[r][c] = 1
                result += 1

                if r > 0 && visited[r-1][c] == 0 {
                    queue.append((r - 1, c, grid[r-1][c]))
                    visited[r-1][c] = 1
                }
                if c > 0 && visited[r][c-1] == 0 {
                    queue.append((r, c - 1, grid[r][c-1]))
                    visited[r][c-1] = 1
                }
                if r < m - 1 && visited[r+1][c] == 0 {
                    queue.append((r + 1, c, grid[r+1][c]))
                    visited[r+1][c] = 1
                }
                if c < n - 1 && visited[r][c+1] == 0 {
                    queue.append((r, c + 1, grid[r][c+1]))
                    visited[r][c+1] = 1
                }
            }
        }

        let q = queries.count
        for i in 0..<q {
            if i > 0 {
                // 更大的 target 走过的路包含较小的 target
                sorted[i].2 += sorted[i-1].2
                // 相同 query 不需要重复计算
                if sorted[i].1 == sorted[i-1].1 {
                    sorted[i].2 = sorted[i-1].2
                    continue
                }
            }
            _bfs(sorted[i].1, &sorted[i].2)
        }


        var ans = [Int](repeating: 0, count: q)
        for pair in sorted {
            ans[pair.0] = pair.2
        }
        return ans
    }
}

class Allocator {
    var array: [Int]
    var n = 0

    init(_ n: Int) {
        array = [Int](repeating: 0, count: n)
        self.n = n
    }

    func allocate(_ size: Int, _ mID: Int) -> Int {
        var i = 0
        var count = 0, beg = 0
        while i < n && count < size {
            while i < n && array[i] != 0 {
                i += 1
            }
            beg = i
            var found = false
            while i < n && array[i] == 0 {
                count += 1
                if count == size {
                    found = true
                    break
                }
                i += 1
            }
            if found {
                for j in beg..<beg+size {
                    array[j] = mID
                }
                return beg
            } else {
                count = 0
            }
        }
        return -1
    }

    func free(_ mID: Int) -> Int {
        var count = 0
        for i in 0..<n {
            if array[i] == mID {
                count += 1
                array[i] = 0
            }
        }
        return count
    }
}

// @lc code=end

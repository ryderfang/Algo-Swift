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
        var path = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: m)
        path[0][0] = grid[0][0] + 1
        var reLoop = true
        while reLoop {
            reLoop = false
            for i in 0..<m {
                for j in 0..<n {
                    if i == 0 && j == 0 {
                        continue
                    }
                    var tmp = Int.max
                    if i > 0 {
                        tmp = min(tmp, path[i-1][j])
                    }
                    if j > 0 {
                        tmp = min(tmp, path[i][j-1])
                    }
                    if i < m - 1 {
                        tmp = min(tmp, path[i+1][j])
                    }
                    if j < n - 1 {
                        tmp = min(tmp, path[i][j+1])
                    }
                    let new = min(max(tmp, grid[i][j] + 1), path[i][j])
                    if path[i][j] != new {
                        path[i][j] = new
                        reLoop = true
                    }
                }
            }
        }
        var ans = [Int]()
        for x in queries {
            var result = 0
            for i in 0..<m {
                for j in 0..<n {
                    if path[i][j] <= x {
                        result += 1
                    }
                }
            }
            ans.append(result)
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

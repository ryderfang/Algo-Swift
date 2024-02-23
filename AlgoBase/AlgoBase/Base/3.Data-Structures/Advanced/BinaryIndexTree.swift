//
//  BinaryIndexTree.swift
//  AlgoBase
//
//  Created by ryfang on 2023/10/25.
//

import Foundation

// 树状数组，O(logn) 更新与查询区间和
// Fenwick Tree: https://cp-algorithms.com/data_structures/fenwick.html
/*
 * lowbit - 最低位 1 与其后的 0 组成的数
 * bit[i] = sum(nums[i-lowbit(i)+1] ... nums[i]) (lowbit(i) 个元素之和)
 *
               8
       4     / |
   2   |   6   |
 1 | 3 | 5 | 7 | ... (bit)
 1 2 3 4 5 6 7 8 ... (nums)
*/

// MARK: - 单点更新，区间查询
class BinaryIndexTree {
    // [0, n)
    private var nums: [Int]
    // [1, n]
    private var bit: [Int]
    private var n: Int = 0
    private var total: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
//        x & ( x ^ (x - 1))
    }

    init(_ nums: [Int]) {
        n = nums.count
        self.nums = [Int](repeating: 0, count: n + 1)
        bit = [Int](repeating: 0, count: n + 1)
        for i in 0..<nums.count {
            update(i, nums[i])
        }
    }

    // nums[i] += d
    func add(_ i: Int, _ d: Int) {
        assert(i >= 0 && i < n)
        total += d
        nums[i] += d
        var p = i + 1
        while p <= n {
            bit[p] += d
            p += lowbit(p)
        }
    }

    // nums[i] = v
    func update(_ i: Int, _ v: Int) {
        assert(i >= 0 && i < n)
        add(i, v - nums[i])
    }

    // sum of [0...index]
    func query(_ i: Int) -> Int {
        guard i >= 0 && i < n else { return 0 }
        var ans = 0
        var p = i + 1
        while p > 0 {
            ans += bit[p]
            p -= lowbit(p)
        }
        return ans
    }

    // sum of [i...j]
    func query(_ i: Int, _ j: Int) -> Int {
        return query(j) - query(i - 1)
    }

    // sum of [i...n]
    func suffix(_ i: Int) -> Int {
        total - query(i - 1)
    }
}

// MARK: - 区间更新，单点查询
class BinaryIndexTreeEx {
    // [0, n)
    private var nums: [Int]
    // [1, n]
    private var bit: [Int] // -> add count of range [i - lowbit(i) + 1, i]
    private var n: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
//        x & ( x ^ (x - 1))
    }

    init(_ n: Int) {
        self.n = n
        self.nums = [Int](repeating: 0, count: n + 1)
        bit = [Int](repeating: 0, count: n + 1)
    }

    // add `v` to nums in [x...y]
    func add(_ x: Int, _ y: Int, _ v: Int) {
        guard y >= x else { return }
        update(y, v)
        update(x - 1, -v)
    }

    // add `v` to nums in [0, i]
    func update(_ i: Int, _ v: Int) {
        var p = i + 1
        while p > 0 {
            bit[p] += v
            p -= lowbit(p)
        }
    }

    // nums[i]
    func query(_ i: Int) -> Int {
        guard i >= 0 && i < n else { return 0 }
        var ans = 0
        var p = i + 1
        while p <= n {
            ans += bit[p]
            p += lowbit(p)
        }
        return ans
    }
}

// MARK: - 左边比 nums[i] 小的数的个数
extension BinaryIndexTree {
    // nums[i] <- [-1e4, 1e4]
    static func leftLessCounts(_ nums: [Int], _ index: Int) -> Int {
        let offSet = Int(1e4)
        let bit = BinaryIndexTree([Int](repeating: 0, count: offSet * 10))
        // 将 nums 转换成非负整数
        for i in 0..<index {
            bit.update(nums[i] + offSet, 1)
        }
        return bit.query(nums[index] + offSet - 1)
    }
}

// 二维树状数组 (lc 308)
// 子矩阵和
// MARK: - 二维树状数组
class BinaryIndexTree2 {
    private var matrix: [[Int]]
    private var bit: [[Int]]
    private var m: Int = 0
    private var n: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
    }
    
    init(_ matrix: [[Int]]) {
        m = matrix.count
        n = matrix[0].count
        self.matrix = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        bit = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        for i in 0..<m {
            for j in 0..<n {
                update(i, j, matrix[i][j])
            }
        }
    }

    func update(_ row: Int, _ col: Int, _ val: Int) {
        let diff = val - matrix[row+1][col+1]
        var i = row + 1
        while i <= m {
            var j = col + 1
            while j <= n {
                bit[i][j] += diff
                j += lowbit(j)
            }
            i += lowbit(i)
        }
        matrix[row+1][col+1] = val
    }

    func query(_ row: Int, _ col: Int) -> Int {
        guard (0..<m).contains(row) && (0..<n).contains(col) else { return 0 }
        var ans = 0
        var i = row + 1
        while i > 0 {
            var j = col + 1
            while j > 0 {
                ans += bit[i][j]
                j -= lowbit(j)
            }
            i -= lowbit(i)
        }
        return ans
    }

    func query(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        return query(row2, col2) - query(row1 - 1, col2) - query(row2, col1 - 1) + query(row1 - 1, col1 - 1)
    }
}

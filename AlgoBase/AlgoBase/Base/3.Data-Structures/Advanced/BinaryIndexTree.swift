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
 * 101011 = (101010, 101011] + (101000, 101010] + (100000, 101000] + (000000, 100000]
 * lowbit - 最低位 1 与其后的 0 组成的数
 * bit[x] = nums[x] when (x ^ 1 == 1)
 * bit[0] = 0, bit[1] = nums[1], bit[2] = bit[1] + nums[2],
 * bit[10] = bit[10] + bit[8] ...
 */
fileprivate class BinaryIndexTree {
    private var nums: [Int]
    // [1...n]
    private var bit: [Int]
    private var n: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
//        x & ( x ^ (x - 1))
    }

    init(_ nums: [Int]) {
        n = nums.count
        self.nums = [Int](repeating: 0, count: n)
        bit = [Int](repeating: 0, count: n + 1)
        for i in 0..<nums.count {
            update(i, nums[i])
        }
    }

    func update(_ index: Int, _ val: Int) {
        let diff = val - nums[index+1]
        var p = index+1
        while p <= n {
            bit[p] += diff
            p += lowbit(p)
        }
        nums[index+1] = val
    }

    func query(_ index: Int) -> Int {
        guard index >= 0 && index < n else { return 0 }
        var ans = 0
        var p = index + 1
        while p > 0 {
            ans += bit[p]
            p -= lowbit(p)
        }
        return ans
    }

    func query(_ left: Int, _ right: Int) -> Int {
        return query(right) - query(left-1)
    }
}

// 二维树状数组 (lc 308)
// 子矩阵和
fileprivate class BinaryIndexTree2 {
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

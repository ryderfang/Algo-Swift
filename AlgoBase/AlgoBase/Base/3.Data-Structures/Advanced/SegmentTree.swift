//
//  SegmentTree.swift
//  AlgoBase
//
//  Created by ryfang on 2023/10/25.
//

import Foundation

fileprivate class SegmentTree {
    private var tree: [Int]
    private var n: Int

    init(_ nums: [Int]) {
        n = nums.count
        tree = [Int](repeating: 0, count: n * 2)
        buildTree(nums)
    }

    func update(_ index: Int, _ val: Int) {
        var i = index + n
        tree[i] = val
        while i > 0 {
            tree[i / 2] = tree[i] + tree[i ^ 1]
            i /= 2
        }
    }

    func query(_ left: Int, _ right: Int) -> Int {
        var ans = 0
        var i = left + n
        var j = right + n
        while i <= j {
            if (i & 1) == 1 {
                ans += tree[i]
                i += 1
            }
            if (j & 1) == 0 {
                ans += tree[j]
                j -= 1
            }
            i /= 2
            j /= 2
        }
        return ans
    }

    private func buildTree(_ nums: [Int]) {
        for i in n..<2*n {
            tree[i] = nums[i-n]
        }
        for i in (1..<n).reversed() {
            tree[i] = tree[i * 2] + tree[i * 2 + 1]
        }
    }
}

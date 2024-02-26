//
//  SegmentTree.swift
//  AlgoBase
//
//  Created by ryfang on 2023/10/25.
//

import Foundation

/*
 求和线段树
 */
class SegmentTree {
    // [1, 2*n)
    private var tree: [Int]
    private var n: Int = 0
    private var total: Int = 0

    // tree[i+n] = nums[i]
    init(_ nums: [Int]) {
        n = nums.count
        tree = [Int](repeating: 0, count: n * 2)
        buildTree(nums)
        total = nums.reduce(0, +)
    }

    // nums[i] += v
    func add(_ i: Int, _ v: Int) {
        update(i, v + tree[i + n])
    }

    // nums[index] = v
    func update(_ index: Int, _ v: Int) {
        var i = index + n
        total += (v - tree[i])
        tree[i] = v
        while i > 0 {
            tree[i / 2] = tree[i] + tree[i ^ 1]
            i /= 2
        }
    }

    // sum of [0...index]
    func query(_ index: Int) -> Int {
        guard index >= 0 && index < n else { return 0 }
        return query(0, index)
    }

    // sum of [left...right]
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

    // sum of [index...n)
    func suffix(_ index: Int) -> Int {
        total - query(index - 1)
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

// MARK: 泛型
fileprivate class SegmentTreeEx<T> {
    private var value: T
    private var function: (T, T) -> T
    private var leftBound: Int
    private var rightBound: Int
    private var leftChild: SegmentTreeEx<T>?
    private var rightChild: SegmentTreeEx<T>?

    /* function can be:
     sum / multi / min / max / gcd, etc..
    - sum: SegmentTreeEx(nums, +)
    **/
    convenience init(array: [T], function: @escaping (T, T) -> T) {
        self.init(array: array, leftBound: 0, rightBound: array.count-1, function: function)
    }

    init(array: [T], leftBound: Int, rightBound: Int, function: @escaping (T, T) -> T) {
        self.leftBound = leftBound
        self.rightBound = rightBound
        self.function = function

        if leftBound == rightBound {
            value = array[leftBound]
        } else {
            let middle = (leftBound + rightBound) / 2
            leftChild = SegmentTreeEx<T>(array: array, leftBound: leftBound, rightBound: middle, function: function)
            rightChild = SegmentTreeEx<T>(array: array, leftBound: middle+1, rightBound: rightBound, function: function)
            value = function(leftChild!.value, rightChild!.value)
        }
    }


    func query(leftBound: Int, rightBound: Int) -> T {
        if self.leftBound == leftBound && self.rightBound == rightBound {
            return self.value
        }

        guard let leftChild = leftChild else { fatalError("leftChild should not be nil") }
        guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }

        if leftChild.rightBound < leftBound {
            return rightChild.query(leftBound: leftBound, rightBound: rightBound)
        } else if rightChild.leftBound > rightBound {
            return leftChild.query(leftBound: leftBound, rightBound: rightBound)
        } else {
            let leftResult = leftChild.query(leftBound: leftBound, rightBound: leftChild.rightBound)
            let rightResult = rightChild.query(leftBound:rightChild.leftBound, rightBound: rightBound)
            return function(leftResult, rightResult)
        }
    }

    func replaceItem(at index: Int, withItem item: T) {
        if leftBound == rightBound {
            value = item
        } else if let leftChild = leftChild, let rightChild = rightChild {
            if leftChild.rightBound >= index {
                leftChild.replaceItem(at: index, withItem: item)
            } else {
                rightChild.replaceItem(at: index, withItem: item)
            }
            value = function(leftChild.value, rightChild.value)
        }
    }
}

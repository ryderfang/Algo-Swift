/*
 * @lc app=leetcode id=307 lang=swift
 *
 * [307] Range Sum Query - Mutable
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class NumArray {
    private var bit: BinaryIndexTree
    private var st: SegmentTree

    init(_ nums: [Int]) {
        bit = BinaryIndexTree(nums)
        st = SegmentTree(nums)
    }
    
    func update(_ index: Int, _ val: Int) {
        bit.update(index, val)
        st.update(index, val)
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
//        return bit.query(left, right)
        return st.query(left, right)
    }
}

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

fileprivate class BinaryIndexTree {
    // [1...n]
    private var nums: [Int]
    private var tree: [Int]
    private var n: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
    }

    init(_ nums: [Int]) {
        n = nums.count
        self.nums = [Int](repeating: 0, count: n + 1)
        tree = [Int](repeating: 0, count: n + 1)
        for i in 0..<nums.count {
            update(i, nums[i])
        }
    }

    func update(_ index: Int, _ val: Int) {
        let diff = val - nums[index+1]
        nums[index+1] = val
        var p = index+1
        while p <= n {
            tree[p] += diff
            p += lowbit(p)
        }
    }

    func query(_ index: Int) -> Int {
        guard index >= 0 && index < n else { return 0 }
        var ans = 0
        var p = index + 1
        while p > 0 {
            ans += tree[p]
            p -= lowbit(p)
        }
        return ans
    }

    func query(_ left: Int, _ right: Int) -> Int {
        return query(right) - query(left-1)
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * let obj = NumArray(nums)
 * obj.update(index, val)
 * let ret_2: Int = obj.sumRange(left, right)
 */
// @lc code=end

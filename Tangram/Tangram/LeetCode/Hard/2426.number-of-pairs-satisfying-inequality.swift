/*
 * @lc app=leetcode id=2426 lang=swift
 *
 * [2426] Number of Pairs Satisfying Inequality
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 0 <= i < j <= n - 1, nums1/nums2/diff <- [-10^4, 10^4]
    // nums1[i] - nums1[j] <= nums2[i] - nums2[j] + diff
    // (nums1[i] - nums2[i]) - (nums1[j] - nums2[j]) <= diff
    // d[i] <= d[j] + diff
    func numberOfPairs(_ nums1: [Int], _ nums2: [Int], _ diff: Int) -> Int {
        let n = nums1.count
        let d = zip(nums1, nums2).map { $0 - $1 }
        let maxSize = Int(10e5)
//        let st = SegmentTree([Int](repeating: 0, count: maxSize))
        let st = BinaryIndexTree([Int](repeating: 0, count: maxSize))
        var ans = 0
        // make value to positive to be index
        let offSet = Int(3 * 10e4 + 1)
        for j in 0..<n {
            // find count of d[i] <= d[j] + diff, where i < j
            ans += st.query(0, d[j] + diff + offSet)
            // d[j]'s count + 1
            st.add(d[j] + offSet, 1)
        }
        return ans
    }
}

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

    func add(_ index: Int, _ val: Int) {
        let diff = val
        var p = index+1
        while p <= n {
            bit[p] += diff
            p += lowbit(p)
        }
        nums[index] = val
    }

    func update(_ index: Int, _ val: Int) {
        let diff = val - nums[index]
        var p = index+1
        while p <= n {
            bit[p] += diff
            p += lowbit(p)
        }
        nums[index] = val
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

fileprivate class SegmentTree {
    private var tree: [Int]
    private var n: Int

    init(_ nums: [Int]) {
        n = nums.count
        tree = [Int](repeating: 0, count: n * 2)
        buildTree(nums)
    }

    func add(_ index: Int, _ val: Int) {
        var i = index + n
        // Diff
        tree[i] += val
        while i > 0 {
            tree[i / 2] = tree[i] + tree[i ^ 1]
            i /= 2
        }
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

// @lc code=end

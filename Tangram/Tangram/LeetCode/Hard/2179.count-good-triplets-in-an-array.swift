/*
 * @lc app=leetcode id=2179 lang=swift
 *
 * [2179] Count Good Triplets in an Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 3 <= nums.length <= 10^5
    func goodTriplets(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        // x's index in nums1
        var idx1 = [Int](repeating: 0, count: n)
        for (i, v) in nums1.enumerated() {
            idx1[v] = i
        }
        var seg = SegmentTree([Int](repeating: 0, count: n + 1))
        var less = [Int](repeating: 0, count: n)
        for i in 0..<n {
            // nums2[i]'s index in nums1
            let idx2 = idx1[nums2[i]]
            less[nums2[i]] = seg.query(idx2)
            seg.update(idx2, 1)
        }
        var greater = [Int](repeating: 0, count: n)
        // reset
        seg = SegmentTree([Int](repeating: 0, count: n + 1))
        for i in stride(from: n-1, through: 0, by: -1) {
            let idx2 = idx1[nums2[i]]
            greater[nums2[i]] = seg.suffix(idx2)
            seg.update(idx2, 1)
        }

        var ans = 0
        for i in 0..<n {
            ans += less[i] * greater[i]
        }
        return ans
    }
}

fileprivate class SegmentTree {
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

// @lc code=end

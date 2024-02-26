/*
 * @lc app=leetcode id=315 lang=swift
 *
 * [315] Count of Smaller Numbers After Self
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countSmaller(_ nums: [Int]) -> [Int] {
        let n = nums.count
        let maxSize = Int(1e5)
        let seg = SegmentTree([Int](repeating: 0, count: maxSize))
        var ans = [Int]()
        // make all nums not negative
        let offSet = Int(1e4 + 1)
        for i in stride(from: n-1, through: 0, by: -1) {
            ans.append(seg.query(nums[i] + offSet - 1))
            seg.add(nums[i] + offSet, 1)
        }
        return Array(ans.reversed())
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


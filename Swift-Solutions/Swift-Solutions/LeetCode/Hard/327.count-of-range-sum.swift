/*
 * @lc app=leetcode id=327 lang=swift
 *
 * [327] Count of Range Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    /* n <- [1, 1e5]
     nums[i] <- [Int.min, Int.max]
     -1e5 <= lower <= upper <= 1e5
    */
    // MARK: Segment Tree (or BIT)
    func countRangeSum(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        // prefixSum[i] = sum[0,i-1]
        var prefixSum: [Int] = [0]
        var ans = 0, sum = 0
        let n = nums.count
        for x in nums {
            sum += x
            prefixSum.append(sum)
        }
        /*
         lower <= s[i,j] <= upper
         s[i,j] = s[i] - s[j]
         lower + s[j] <= s[i] <= upper + s[j]
         */
        let sorted = prefixSum.sorted()
        // record flag of sum[i]
        let seg = SegmentTree([Int](repeating: 1, count: n + 1))
        // s == 0 -> check lower <= sum[j] <= upper
        for s in prefixSum {
            // lower_bound of s
            let idx = sorted.bisectLeft(s)
            let lowIdx = sorted.bisectLeft(s + lower)
            let upIdx = sorted.bisectRight(s + upper) - 1
            // clear flag of sum[i]
            seg.add(idx, -1)
            ans += seg.query(lowIdx, upIdx)
        }
        return ans
    }

    // MARK: Binary Search
    func countRangeSum1(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        var prefixSum = [0]
        var ans = 0, sum = 0
        for x in nums {
            sum += x
            ans += prefixSum.bisectRight(sum - lower) - prefixSum.bisectLeft(sum - upper)
            prefixSum.insort(sum)
        }
        return ans
    }

    // MARK: Merge Sort
    func countRangeSum2(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        let n = nums.count
        var count = 0
        // sum[i] = sum of nums[0,i-1]
        var sums = [0]
        for i in 0..<n {
            sums.append(sums[i] + nums[i])
        }
        count = mergeSort(&sums, 0, n, lower, upper)
        return count
    }

    // merge sort and count the number of valid range sums
    func mergeSort(_ sums: inout [Int], _ left: Int, _ right: Int, _ lower: Int, _ upper: Int) -> Int {
        if left >= right { return 0 }
        let mid = (left + right) / 2
        var count = mergeSort(&sums, left, mid, lower, upper) + mergeSort(&sums, mid + 1, right, lower, upper)

        // count the number of valid range sums that cross mid
        var lo = mid + 1
        var hi = mid + 1
        for i in left...mid {
            while lo <= right && sums[lo] - sums[i] < lower { lo += 1 }
            while hi <= right && sums[hi] - sums[i] <= upper { hi += 1 }
            count += hi - lo
        }

        // merge two sorted subarrays
        var merged = Array(repeating: 0, count: right - left + 1)
        var i = left, j = mid + 1, k = 0
        while i <= mid && j <= right {
            if sums[i] <= sums[j] {
                merged[k] = sums[i]
                i += 1
            } else {
                merged[k] = sums[j]
                j += 1
            }
            k += 1
        }
        while i <= mid {
            merged[k] = sums[i]
            i += 1
            k += 1
        }
        while j <= right {
            merged[k] = sums[j]
            j += 1
            k += 1
        }
        for k in 0..<merged.count {
            sums[left + k] = merged[k]
        }

        return count
    }
}

extension Array where Element: Comparable {
    // count strictly less than target
    func bisectLeft(_ target: Element) -> Int {
        var (lo, hi) = (0, count)
        while lo < hi {
            let mid = lo + (hi - lo) / 2
            if self[mid] < target {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        return lo
    }

    // count less or equal than target
    func bisectRight(_ target: Element) -> Int {
        var (lo, hi) = (0, count)
        while lo < hi {
            let mid = lo + (hi - lo) / 2
            if self[mid] <= target {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        return lo
    }

    mutating func insort(_ element: Element) {
        let i = bisectRight(element)
        insert(element, at: i)
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

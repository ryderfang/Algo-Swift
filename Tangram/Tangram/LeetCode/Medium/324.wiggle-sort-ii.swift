/*
 * @lc app=leetcode id=324 lang=swift
 *
 * [324] Wiggle Sort II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // O(nlogn) | O(n)
    func wiggleSort2(_ nums: inout [Int]) {
        var arr = nums.sorted()
        let n = nums.count
        for i in stride(from: 1, to: n, by: 2) {
            nums[i] = arr.removeLast()
        }
        for i in stride(from: 0, to: n, by: 2) {
            nums[i] = arr.removeLast()
        }
    }

    // O(n) + O(1)
    func wiggleSort(_ nums: inout [Int]) {
        let n = nums.count
        // medium of nums, O(n)
        func _mid(_ nums: inout [Int]) -> Int {
            let n = nums.count, k = n / 2
            var low = 0, high = nums.count - 1
            while low < high - 1 {
                let randomIndex = Int.random(in: low..<high),
                    randomElement = nums[randomIndex],
                    pivot = nums[low..<high].partition { $0 <= randomElement }
                if k < pivot + 1 {
                    high = pivot
                } else if k > pivot + 1 {
                    low = pivot
                    while nums[low] == randomElement, k - low > 1 {
                        low += 1
                    }
                } else {
                    return randomElement
                }
            }
            return nums[low]
        }

        // after partition, nums -> [>mid]mid[<mid]
        let mid = _mid(&nums)

        // idxs:  0  1  2  3   4   5  6  7  8  9
        // nums:  18 17 19 16 [15] 11 14 10 13 12
        // ->
        // idxs:  5  0  6  1  7  2  8  3  9  4
        // nums:  11 18 14 17 10 19 13 16 12 15

        let g = { (i: Int) -> Int in
            return (2 * i + 1) % (n | 1)
        }
        var (i, j, k) = (0, 0, n - 1)
        while j <= k {
            if nums[g(j)] > mid {
                nums.swapAt(g(i), g(j))
                i += 1
                j += 1
            } else if nums[g(j)] < mid {
                nums.swapAt(g(j), g(k))
                k -= 1
            } else {
                j += 1
            }
        }
    }
}

// @lc code=end

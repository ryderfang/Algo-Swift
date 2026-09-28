/*
 * @lc app=leetcode id=1395 lang=swift
 *
 * [1395] Count Number of Teams
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // DP
    func numTeams(_ rating: [Int]) -> Int {
        let n = rating.count
        // dp[i][j] - count of size (i) and end with index (j)
        var dp_inc = [[Int]](repeating: [Int](repeating: 0, count: n), count: 4)
        var dp_dec = [[Int]](repeating: [Int](repeating: 0, count: n), count: 4)
        for i in 0..<n {
            dp_inc[1][i] = 1
            dp_dec[1][i] = 1
        }
        for i in 2...3 {
            for j in 0..<n {
                for k in 0..<j {
                    if rating[j] > rating[k] {
                        dp_inc[i][j] += dp_inc[i-1][k]
                    } else {
                        dp_dec[i][j] += dp_dec[i-1][k]
                    }
                }
            }
        }

        return dp_inc[3].reduce(0, +) + dp_dec[3].reduce(0, +)
    }

    // BIT
    func numTeams2(_ rating: [Int]) -> Int {
        let n = rating.count
        let maxSize = Int(1e5 + 1)
        let bit = BinaryIndexTree([Int](repeating: 0, count: maxSize))
        // count of [0..i) smaller than rating[i]
        var smaller = [Int](repeating: 0, count: n)
        // count of (i..n) bigger than rating[i]
        var bigger = [Int](repeating: 0, count: n)
        for i in 0..<n {
            bit.add(rating[i], 1)
            guard i > 0 else {
                continue
            }
            smaller[i] = bit.query(rating[i] - 1)
        }
        // reset
        for i in 0..<maxSize { bit.update(i, 0) }
        for i in (0..<n).reversed() {
            bit.add(rating[i], 1)
            guard i < n - 1 else {
                continue
            }
            bigger[i] = (n - i) - bit.query(rating[i])
        }
        var ans = 0
        for i in 1..<n-1 {
            // s < [i] < b
            ans += smaller[i] * bigger[i]
            // s > [i] > b
            ans += (i - smaller[i]) * (n - i - 1 - bigger[i])
        }
        return ans
    }
}

fileprivate class BinaryIndexTree {
    // [0, n)
    private var nums: [Int]
    // [1, n]
    private var bit: [Int]
    private var n: Int = 0

    private func lowbit(_ x: Int) -> Int {
        x & (-x)
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
}
// @lc code=end


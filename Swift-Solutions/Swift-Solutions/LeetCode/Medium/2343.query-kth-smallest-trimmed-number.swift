/*
 * @lc app=leetcode id=2343 lang=swift
 *
 * [2343] Query Kth Smallest Trimmed Number
 */

// @lc code=start
class Solution {
    func smallestTrimmedNumbers(_ nums: [String], _ queries: [[Int]]) -> [Int] {
        let maxDigits = nums.map { $0.count }.max() ?? 0
        // reversed: LSD, Least significant digital
        var nums = nums.enumerated().map{ ($0, Array($1.reversed())) }
        var mp = [[(Int, Int)]](repeating: [(Int, Int)](), count: maxDigits)
        // [trimCount: (k, oldIdx)]
        for (i, q) in queries.enumerated() {
            mp[q[1] - 1].append((q[0], i))
        }
        var ans = [Int](repeating: 0, count: queries.count)
        var done = false
        var trimCount = 0
        while !done && trimCount < maxDigits {
            done = true
            var buckets: [[(Int, Array<Character>)]] = []
            for _ in 1...10 {
                buckets.append([])
            }
            for (i, x) in nums {
                let index = Int(String(x[trimCount]))!
                buckets[index].append((i, x))
                if done && index > 0 {
                    done = false
                }
            }

            var i = 0
            for j in 0..<10 {
                let bucket = buckets[j]
                for ele in bucket {
                    nums[i] = ele
                    i += 1
                }
            }

            for (k, i) in mp[trimCount] {
                ans[i] = nums[k-1].0
            }

            trimCount += 1
        }
        return ans
    }
}
// @lc code=end


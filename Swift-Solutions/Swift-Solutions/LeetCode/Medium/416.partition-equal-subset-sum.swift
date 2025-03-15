/*
 * @lc app=leetcode id=416 lang=swift
 *
 * [416] Partition Equal Subset Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Test cases
    /*
     [1,5,11,5], // true
     [1,2,3,5],  // false
     [1,2,5],    // false
     [100,4,6],  // false
     [2,2,3,5],  // false
     [2,2,1,1],  // true
     */
    // 263ms
    func pack_01_1_(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
        let n = C.count
        var dp = Array(repeating: Array(repeating: Int.min, count: V + 1), count: n + 1)
        dp[0][0] = 0
        for i in 1...n {
            for v in 0...V {
                let (cur_c, cur_w) = (C[i-1], W[i-1])
                dp[i][v] = dp[i-1][v]
                if cur_c <= v && dp[i-1][v-cur_c] != Int.min  {
                    dp[i][v] = max(dp[i][v], dp[i-1][v-cur_c] + cur_w)
                }
            }
        }
        return dp[n][V]
    }
    
    // 17ms
    func pack_01_3(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
        let n = C.count
        var dp = Array(repeating: Int.min, count: V + 1)
        dp[0] = 0
        for i in 0..<n {
            guard C[i] <= V else { continue }
            for v in stride(from: V, through: C[i], by: -1) {
                if dp[v-C[i]] != Int.min {
                    dp[v] = max(dp[v], dp[v-C[i]] + W[i])
                }
            }
        }
        return dp[V]
    }
    
    // Best: 13ms
    func pack_01_4_(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
        let n = C.count
        var dp = Array(repeating: Int.min, count: V + 1)
        dp[0] = 0
        var sumCost = C.reduce(0, +)
        for i in 0..<n {
            sumCost -= C[i]
            guard C[i] <= V else { continue }
            let lowBound = max(V - sumCost, C[i])
            for v in stride(from: V, through: lowBound, by: -1) {
                if dp[v-C[i]] != Int.min {
                    dp[v] = max(dp[v], dp[v-C[i]] + W[i])
                }
            }
        }
        return dp[V]
    }
    
    // 21ms
    func pack_01_5_(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
        typealias _Item = (Int, Int)
        let n = C.count
        var items = [_Item]()
        var sumCost = 0
        for i in 0..<n {
            items.append(_Item(C[i], W[i]))
            sumCost += C[i]
        }
        // sort by cost descending order
        items.sort(by: { $0.0 > $1.0 })
        var dp = Array(repeating: Int.min, count: V + 1)
        dp[0] = 0
        func _zero_one_pack(_ cost: Int, _ weight: Int) {
            sumCost -= cost
            guard cost <= V else { return }
            let bound = max(V - sumCost, cost)
            for v in stride(from: V, through: bound, by: -1) {
                if dp[v-cost] != Int.min {
                    dp[v] = max(dp[v], dp[v-cost] + weight)
                }
            }
        }
        
        for i in 0..<n {
            _zero_one_pack(items[i].0, items[i].1)
        }
        return dp[V]
    }

    
    // 转换成 0-1 背包问题，背包容易 sum / 2
    func canPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        let sum = nums.reduce(0, +)
        guard sum % 2 == 0 else { return false }
        let W = [Int](repeating: 1, count: n)
        // max count of nums after partitioning
        let ans = pack_01_4_(sum / 2, nums, W)
        return ans != Int.min
    }
}
// @lc code=end


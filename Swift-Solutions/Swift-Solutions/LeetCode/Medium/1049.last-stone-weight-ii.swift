/*
 * @lc app=leetcode id=1049 lang=swift
 *
 * [1049] Last Stone Weight II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution: 0-1 knapsack(背包) problem
    /*
     Given a set of items with weight `w[]` and value `v[]`
     Put some of them to a bag with capacity `W`, and maximize profit.
     For this question,
     -> w[i] = v[i] = stones[i]
     -> W = sum(stones) / 2
     */
    func lastStoneWeightII(_ stones: [Int]) -> Int {
        let n = stones.count
        let sum = stones.reduce(0, +)
        let halfTotal = sum / 2
        var dp = [Int](repeating: 0, count: halfTotal + 1)
        for i in 0..<n {
            for j in stride(from: halfTotal, through: stones[i], by: -1) {
                dp[j] = max(dp[j], dp[j-stones[i]] + stones[i])
            }
        }
        return sum - 2 * dp[halfTotal]
    }
    
    // n <- [1, 30]
    func lastStoneWeightII1(_ stones: [Int]) -> Int {
        var tmp = Set<Int>()
        let n = stones.count
        guard n > 1 else { return stones[0] }
        tmp.insert(stones[0])
        tmp.insert(-stones[0])
        for i in 1..<n {
            var next = Set<Int>()
            for x in tmp {
                next.insert(x + stones[i])
                next.insert(x - stones[i])
            }
            tmp = next
        }
        let sorted = tmp.map { abs($0) }.sorted()
        return sorted[0]
    }
}
// @lc code=end


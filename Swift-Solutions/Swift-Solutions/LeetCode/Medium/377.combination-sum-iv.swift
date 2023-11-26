/*
 * @lc app=leetcode id=377 lang=swift
 *
 * [377] Combination Sum IV
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: O(n * target)
    func __combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var dp = [Int](repeating: 0, count: target + 1)
        let mod = 2147483647
        dp[0] = 1
        for i in 1...target {
            for num in nums {
                if i >= num {
                    dp[i] = (dp[i] + dp[i - num]) % mod
                }
            }
        }
        return dp[target]
    }

    // O(n * target)
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var cache = [Int: Int]()
        cache[0] = 1
        func _solve(_ nums: [Int], _ target: Int, _ cache: inout [Int: Int]) -> Int {
            guard target >= 0 else { return 0 }
            if let saved = cache[target] {
                return saved
            }

            var ret = 0
            for num in nums {
                ret += _solve(nums, target - num, &cache)
            }
            cache[target] = ret
            return ret
        }
        return _solve(nums, target, &cache)
    }


    // 硬算 + 强行优化
    func _combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        typealias ITEM = (count: Int, result: Int)
        // C(a, b) = (a + b)! / (a! * b!)
        func _getNextComb(_ item: ITEM, _ add: Int) -> ITEM {
            var ret = item.result
            for i in 1...add {
                ret = ret * (item.count + i) / i
            }
            return (count: item.count + add, result: ret)
        }

        let nums = nums.sorted()
        let n = nums.count
        var dp = [[ITEM]](repeating: [ITEM](), count: target + 1)
        var need = [Bool](repeating: false, count: target + 1)
        var targets = Set<Int>([target])
        for i in 0..<n {
            for t in targets {
                var tt = t - nums[i]
                while tt >= 0 {
                    targets.insert(tt)
                    tt -= nums[i]
                }
            }
        }
        for t in targets {
            need[t] = true
        }

        for i in 0..<n {
            let last = dp
            var (k, ki) = (1, nums[i])
            while ki <= target {
                dp[ki].append((count: k, result: 1))
                for j in 1..<target {
                    guard need[j] else { continue }
                    guard j + ki <= target else { break }
                    if last[j].count > 0 {
                        dp[j + ki].append(contentsOf: last[j].map {
                            _getNextComb($0, k)
                        })
                    }
                }
                k += 1
                ki += nums[i]
            }
        }
        var ans = 0
        for l in dp[target] {
            ans += l.result
        }
        return ans
    }
}
// @lc code=end


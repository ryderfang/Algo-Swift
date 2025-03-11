//
//  WeeklyContest439.swift
//  Titan
//
//  Created by ryfang on 2023/11/12.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // lc3471
    func largestInteger(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        if k == 1 {
            var mp = [Int: Int]()
            for i in 0..<n {
                mp[nums[i], default: 0] += 1
            }
            return (mp.filter({ $0.value == 1 }).keys.max() ?? -1)
        } else if k == n {
            return nums.max() ?? -1
        }
        // 1 < k < n
        // others elements should appear more than once
        let ans = max(Set(nums[1..<n]).contains(nums[0]) ? -1 : nums[0],
                      Set(nums[0..<n-1]).contains(nums[n-1]) ? -1 : nums[n-1])
        return ans
    }
    
    // lc3472
    func longestPalindromicSubsequence(_ s: String, _ k: Int) -> Int {
        // dp[i][j][k] is answer of the substring [i..j] with cost at most k
        // dp[i][j][k] = max(dp[i + 1][j][k], dp[i][j - 1][k], dp[i + 1][j - 1][k - dist(s[i], s[j])] + 2)
        // * dist(x, y) is the minimum cyclic distance between x and y
        let s = Array(s)
        let n = s.count
        var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: k + 1), count: n), count: n)
        
        func _dist(_ ch1: Character, _ ch2: Character) -> Int {
            let index1 = (ch1.asciiValue! - 97)
            let index2 = (ch2.asciiValue! - 97)
            let minIndex = min(index1, index2)
            let maxIndex = max(index1, index2)
            return Int(min(maxIndex - minIndex, minIndex + 26 - maxIndex))
        }
        
        func _solve(_ i: Int, _ j: Int, _ l: Int) -> Int {
            guard dp[i][j][l] == 0 else { return dp[i][j][l] }
            if i == j {
                dp[i][i][l] = 1
                return dp[i][i][l]
            }
            dp[i][j][l] = max(_solve(i + 1, j, l), _solve(i, j - 1, l))
            let dist = _dist(s[i], s[j])
            if l >= dist {
                if i + 1 == j {
                    dp[i][j][l] = max(dp[i][j][l], 2)
                } else if i + 1 <= j - 1 {
                    dp[i][j][l] = max(dp[i][j][l], _solve(i + 1, j - 1, l - dist) + 2)
                }
            }
            return dp[i][j][l]
        }
        let ans = _solve(0, n - 1, k)
        return ans
    }
    
    // lc3473
    func maxSum(_ nums: [Int], _ k: Int, _ m: Int) -> Int {
        let n = nums.count
        var preSum = [Int](repeating: 0, count: n + 1)
        for i in 0..<n {
            preSum[i+1] = preSum[i] + nums[i]
        }
        // max sum with i subarrays for j elements
        let NEG = -Int(1e18)
        var dp = [[Int]](repeating: [Int](repeating: NEG, count: n + 1), count: k + 1)
        for j in 0...n {
            dp[0][j] = 0
        }
        for i in 1...k {
            // pre-compute, l <- [1..(j-m)]
            var best = [Int](repeating: NEG, count: n + 1)
            let start = (i - 1) * m
            best[start] = dp[i-1][start] - preSum[start]
            for l in (start+1)...n {
                best[l] = max(best[l-1], dp[i-1][l] - preSum[l])
            }
            
            for j in (i*m)...n {
                /* two options:
                 * - not take subarray end with [j]
                 * - take subarray end with [j], which starts from [1, j-m]
                */
                if j > i * m {
                    dp[i][j] = dp[i][j-1]
                }
                if j - m >= start {
                    dp[i][j] = max(dp[i][j], best[j-m] + preSum[j])
                }
            }
        }
        return dp[k][n]
    }
}

// @lc code=end


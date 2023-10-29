//
//  BiweeklyContest116.swift
//  Titan
//
//  Created by ryfang on 2023/10/28.
//

#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 1 <= nums.length <= 100
    func sumCounts(_ nums: [Int]) -> Int {
        var ans = 0
        let n = nums.count
        for i in 0..<n {
            for j in i..<n {
                let st = Set<Int>(Array(nums[i...j]))
                ans += st.count * st.count
            }
        }
        return ans
    }

    func minChanges(_ s: String) -> Int {
        let n = s.count
        let arr = Array(s)
        var ans = 0
        for i in stride(from: 0, to: n, by: 2) {
            if arr[i] != arr[i+1] {
                ans += 1
            }
        }
        return ans
    }

    func lengthOfLongestSubsequence(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        var dp = [Int](repeating: -1, count: target + 1)
        dp[0] = 0
        for i in 0..<n {
            // !! reversed
            var j = target
            while j >= nums[i] {
                if dp[j-nums[i]] >= 0 {
                    dp[j] = max(dp[j-nums[i]] + 1, dp[j])
                }
                j -= 1
            }
        }
        return dp[target]
    }

    // 1 <= nums.length <= 10^5
    func sumCounts2(_ nums: [Int]) -> Int {
        // 线段树？
        0
    }
}

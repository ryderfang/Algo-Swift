/*
 * @lc app=leetcode id=413 lang=swift
 *
 * [413] Arithmetic Slices
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // n <- [1, 5000], nums[i] <- [-1000, 1000]
    // subarray - *contiguous* subsequence
    func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n >= 3 else { return 0 }
        var len = 1, diff = 0
        var ret = 0
        for i in 1..<n {
            // Not "abs" diff
            let newVal = nums[i] - nums[i-1]
            if len < 2 {
                diff = newVal
                len += 1
                continue
            }
            if diff == newVal {
                len += 1
            } else {
                if len >= 3 {
                    // (n-2) + (n-3) + ... + 1
                    // let tmp = ((i-len)...(i-1)).map { nums[$0] }
                    // print(i, tmp, diff, ret)
                    ret += ((len - 2) * (len - 1) / 2)
                }
                // reset
                diff = newVal
                len = 2
            }
        }
        // last included
        if len >= 3 {
            ret += ((len - 2) * (len - 1) / 2)
        }
        return ret
    }


    // if do not need contiguous
    func _numberOfArithmeticSlices2(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n >= 3 else { return 0 }
        let maxDiff = 2001
        // dp[i][k], count with diff [k] when end of i
        var dp = [[Int]](repeating: [Int](repeating: 0, count: maxDiff), count: n)
        var ret = 0
        var repeated = 0
        for i in 1..<n {
            for j in 0..<i {
                let diff = abs(nums[i] - nums[j])
                dp[i][diff] += dp[j][diff]
                // only j, i
                dp[i][diff] += 1
                repeated += 1
            }
        }
        for i in 0..<n {
            for k in 0..<maxDiff {
                ret += dp[i][k]
            }
        }
        ret -= repeated
        return ret
    }
}
// @lc code=end


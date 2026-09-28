/*
 * @lc app=leetcode id=1031 lang=swift
 *
 * [1031] Maximum Sum of Two Non-Overlapping Subarrays
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func maxSumTwoNoOverlap(_ nums: [Int], _ firstLen: Int, _ secondLen: Int) -> Int {
        let n = nums.count
        // sum of [i, i+firstLen)
        var firstSum = [Int](repeating: 0, count: n)
        // maxSum of [i, n)
        var maxFirst = [Int](repeating: 0, count: n)
        var secondSum = [Int](repeating: 0, count: n)
        var maxSecond = [Int](repeating: 0, count: n)
        // [0, n - firstLen]
        for i in (0...n-firstLen).reversed() {
            if i == n - firstLen {
                maxFirst[i] = (n-firstLen..<n).reduce(0, { partialResult, x in
                    partialResult + nums[x]
                })
                firstSum[i] = maxFirst[i]
            } else {
                firstSum[i] = firstSum[i+1] + nums[i] - nums[i+firstLen]
                maxFirst[i] = max(maxFirst[i+1], firstSum[i])
            }
        }
        // [0, n - secondLen]
        for i in (0...n-secondLen).reversed() {
            if i == n - secondLen {
                maxSecond[i] = (n-secondLen..<n).reduce(0, { partialResult, x in
                    partialResult + nums[x]
                })
                secondSum[i] = maxSecond[i]
            } else {
                secondSum[i] = secondSum[i+1] + nums[i] - nums[i+secondLen]
                maxSecond[i] = max(maxSecond[i+1], secondSum[i])
            }
        }
        var ans = 0
        // first + second
        for i in 0...n-(firstLen+secondLen) {
            ans = max(ans, firstSum[i] + maxSecond[i+firstLen])
        }
        // second + first
        for i in 0...n-(firstLen+secondLen) {
            ans = max(ans, secondSum[i] + maxFirst[i+secondLen])
        }
        return ans
    }
}

// @lc code=end


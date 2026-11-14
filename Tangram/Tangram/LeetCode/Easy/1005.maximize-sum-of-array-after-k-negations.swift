/*
 * @lc app=leetcode id=1005 lang=swift
 *
 * [1005] Maximize Sum Of Array After K Negations
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func largestSumAfterKNegations(_ nums: [Int], _ k: Int) -> Int {
        var negCount = 0, negSum = 0, posSum = 0
        var absMin = Int.max
        var negTemp = [Int]()
        for x in nums {
            if x < 0 {
                negCount += 1
                negSum += x
                negTemp.append(x)
            } else {
                posSum += x
            }
            absMin = min(absMin, abs(x))
        }
        var ans = posSum - negSum
        if k >= negCount {
            if (k - negCount) % 2 == 1 {
                ans -= (2 * absMin)
            } else {
                // do nothing
            }
        } else {
            negTemp.sort(by: >)
            for i in 0..<(negCount - k) {
                ans += (2 * negTemp[i])
            }
        }
        return ans
    }
}
// @lc code=end

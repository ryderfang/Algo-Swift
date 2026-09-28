/*
 * @lc app=leetcode id=1493 lang=swift
 *
 * [1493] Longest Subarray of 1's After Deleting One Element
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // n <- [1, 1e5]
    func longestSubarray(_ nums: [Int]) -> Int {
        let n = nums.count
        guard n > 1 else { return 0 }
        // how many continuous 1's before i
        var preCount = [Int](repeating: 0, count: n + 1)
        // pos of 0
        var zeroPos = [Int]()
        if nums[0] == 0 {
            zeroPos.append(0)
        }
        var ans = 0
        for i in 1...n {
            if nums[i-1] == 1 {
                preCount[i] = preCount[i-1] + 1
            } else {
                preCount[i] = 0
            }
            ans = max(ans, preCount[i])
            if i < n && nums[i] == 0 {
                zeroPos.append(i)
            }
        }

        let zeroCount = zeroPos.count
        if zeroCount == 0 {
            return n - 1
        }
        for (i, k) in zeroPos.enumerated() {
            let left = preCount[k]
            let right = (i + 1 == zeroCount ? preCount[n] : preCount[zeroPos[i+1]])
            ans = max(ans, left + right)
        }
        return ans
    }

    @_optimize(speed)
    func longestSubarray1(_ nums: [Int]) -> Int {
        nums.reduce(into: (curr: 0, prev: 0, max: 0)) {
            $0.prev += ($1 ^ 1) * ($0.curr - $0.prev + 1)
            $0.curr = $0.curr * $1 + $1
            $0.max = max($0.max, $0.prev + $0.curr)
        }.max - 1
    }
}
// @lc code=end

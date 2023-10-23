//
//  WeeklyContest.swift
//  Titan
//
//  Created by ryfang on 2022/11/26.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func minimumSum(_ nums: [Int]) -> Int {
        var ans = Int.max
        let n = nums.count
        var left = [Int](repeating: -1, count: n)
        var right = [Int](repeating: -1, count: n)
        for i in 1..<n {
            if nums[i] > nums[i-1] {
                left[i] = left[i-1] == -1 ? nums[i-1] : left[i-1]
            } else if nums[i] == nums[i-1] {
                left[i] = left[i-1]
            } else {
                if left[i-1] > -1 {
                    left[i] = (left[i-1] < nums[i]) ? left[i-1] : -1
                } else {
                    left[i] = -1
                }
            }
        }
        for i in (0..<n-1).reversed() {
            if nums[i] > nums[i+1] {
                right[i] = right[i+1] == -1 ? nums[i+1] : right[i+1]
            } else if nums[i] == nums[i+1] {
                right[i] = right[i+1]
            } else {
                if right[i+1] > -1 {
                    right[i] = (right[i+1] < nums[i]) ? right[i+1] : -1
                } else {
                    right[i] = -1
                }
            }
        }
        for i in 0..<n {
            if left[i] > -1 && right[i] > -1 {
                ans = min(ans, left[i] + right[i] + nums[i])
            }
        }
        return ans == Int.max ? -1 : ans
    }
}

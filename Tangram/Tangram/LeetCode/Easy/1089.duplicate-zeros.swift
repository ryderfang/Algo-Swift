/*
 * @lc app=leetcode id=1089 lang=swift
 *
 * [1089] Duplicate Zeros
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func duplicateZeros(_ arr: inout [Int]) {
        let n = arr.count
        guard n > 1 else { return }
        var zcnt = 0
        for i in 0..<n-1 {
            if arr[i] == 0 {
                zcnt += 1
            }
        }
        var i = n - 2
        while zcnt > 0 && i >= 0 {
            if arr[i] == 0 {
                if i + zcnt - 1 < n {
                    arr[i + zcnt - 1] = arr[i]
                }
                if i + zcnt < n {
                    arr[i + zcnt] = 0
                }
                zcnt -= 1
            } else {
                if i + zcnt < n {
                    arr[i + zcnt] = arr[i]
                }
            }
            i -= 1
        }
    }
}
// @lc code=end

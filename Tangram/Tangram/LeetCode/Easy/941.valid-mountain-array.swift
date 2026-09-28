/*
 * @lc app=leetcode id=941 lang=swift
 *
 * [941] Valid Mountain Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func validMountainArray(_ arr: [Int]) -> Bool {
        let n = arr.count
        guard n >= 3 else { return false }
        var up = false, down = false
        for i in 1..<n {
            if arr[i] > arr[i-1] {
                guard !down else { return false }
                up = true
            } else if arr[i] < arr[i-1] {
                down = true
            } else {
                return false
            }
        }
        return up && down
    }
}
// @lc code=end


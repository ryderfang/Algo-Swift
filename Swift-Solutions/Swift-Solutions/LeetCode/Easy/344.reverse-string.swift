/*
 * @lc app=leetcode id=344 lang=swift
 *
 * [344] Reverse String
 */

// @lc code=start
extension Solution {
    func reverseString(_ s: inout [Character]) {
        let n = s.count
        for i in 0..<n/2 {
            s.swapAt(i, n-1-i)
        }
    }
}
// @lc code=end


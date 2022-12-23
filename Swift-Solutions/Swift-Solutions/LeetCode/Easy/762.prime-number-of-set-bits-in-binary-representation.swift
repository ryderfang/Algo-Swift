/*
 * @lc app=leetcode id=762 lang=swift
 *
 * [762] Prime Number of Set Bits in Binary Representation
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countPrimeSetBits(_ left: Int, _ right: Int) -> Int {
        let prime: Set<Int> = [2, 3, 5, 7, 11, 13, 17, 19]
        var ans = 0
        for i in left...right {
            if prime.contains(i.nonzeroBitCount) {
                ans += 1
            }
        }
        return ans
    }
}

// @lc code=end

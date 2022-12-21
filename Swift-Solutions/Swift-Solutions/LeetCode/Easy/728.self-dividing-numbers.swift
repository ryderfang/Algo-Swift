/*
 * @lc app=leetcode id=728 lang=swift
 *
 * [728] Self Dividing Numbers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func selfDividingNumbers(_ left: Int, _ right: Int) -> [Int] {
        var ans = [Int]()
        for i in left...right {
            if i.isSelfDividing() {
                ans.append(i)
            }
        }
        return ans
    }
}

fileprivate extension Int {
    func isSelfDividing() -> Bool {
        guard self > 0 else { return false }
        var n = self
        while n > 0 {
            let digit = n % 10
            guard digit != 0 else { return false }
            guard self % digit == 0 else { return false }
            n /= 10
        }
        return true
    }
}

// @lc code=end


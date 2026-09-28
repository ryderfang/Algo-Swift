/*
 * @lc app=leetcode id=50 lang=swift
 *
 * [50] Pow(x, n)
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        guard abs(x) > Double.ulpOfOne else { return 0 }
        guard n != 0 else { return 1 }
        func _pow(_ x: Double, _ n: Int) -> Double {
            var ans: Double = 1.0
            guard n > 0 else { return 1 }
            guard n > 1 else { return x }
            if n & 1 == 1 {
                ans = x
            }
            let tmp = _pow(x, n / 2)
            return ans * tmp * tmp
        }
        let a = fabs(x)
        let b = abs(n)
        var ans = _pow(a, b)
        if n < 0 {
            ans = 1 / ans
        }
        if x < 0 && (b & 1 == 1) {
            ans = -ans
        }
        return ans
    }
}
// @lc code=end


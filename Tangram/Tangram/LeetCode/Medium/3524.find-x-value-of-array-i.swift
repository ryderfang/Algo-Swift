/*
 * @lc app=leetcode id=3524 lang=swift
 *
 * [3524] Find X Value of Array I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // TODO: TLE
    func resultArray(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count
        let total = (n + 1) * n / 2
        guard k > 1 else { return [total] }
        var res = [Int](repeating: 0, count: k)
        for i in 0..<n {
            var tmp = nums[i]
            var remainder = tmp % k
            for j in i..<n {
                if j > i {
                    tmp = ((tmp % k) * (nums[j] % k)) % k
                    remainder = tmp % k
                }
                res[remainder] += 1
            }
        }
        return res
    }
}
// @lc code=end

/*
 * @lc app=leetcode id=414 lang=swift
 *
 * [414] Third Maximum Number
 */

// @lc code=start
extension Solution {
    func thirdMax(_ nums: [Int]) -> Int {
        var maxn = Int.min, secn = Int.min, thirdn = Int.min
        for x in nums {
            if x > maxn {
                thirdn = secn
                secn = maxn
                maxn = x
            } else if x < maxn && x > secn {
                thirdn = secn
                secn = x
            } else if x < secn && x > thirdn {
                thirdn = x
            }
        }
        return (thirdn == Int.min) ? maxn : thirdn
    }
}
// @lc code=end


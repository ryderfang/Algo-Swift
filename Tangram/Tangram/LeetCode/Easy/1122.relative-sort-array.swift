/*
 * @lc app=leetcode id=1122 lang=swift
 *
 * [1122] Relative Sort Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        var mp = [Int](repeating: 0, count: 1001)
        for x in arr1 {
            mp[x] += 1
        }
        var ans = [Int]()
        for x in arr2 {
            if mp[x] > 0 {
                ans.append(contentsOf: [Int](repeating: x, count: mp[x]))
                mp[x] = 0
            }
        }
        for i in 0..<mp.count {
            if mp[i] > 0 {
                ans.append(contentsOf: [Int](repeating: i, count: mp[i]))
            }
        }
        return ans
    }
}
// @lc code=end

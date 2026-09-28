/*
 * @lc app=leetcode id=599 lang=swift
 *
 * [599] Minimum Index Sum of Two Lists
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
        var mp1 = [String: Int]()
        for i in 0..<list1.count {
            mp1[list1[i]] = i
        }
        var least = Int.max
        var check = [Int](repeating: -1, count: list2.count)
        for i in 0..<list2.count {
            if let idx = mp1[list2[i]] {
                check[i] = idx + i
                least = min(least, idx + i)
            }
        }
        var ans = [String]()
        for i in 0..<list2.count {
            if check[i] == least {
                ans.append(list2[i])
            }
        }
        return ans
    }
}
// @lc code=end


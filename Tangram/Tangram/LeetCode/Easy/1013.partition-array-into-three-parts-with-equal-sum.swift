/*
 * @lc app=leetcode id=1013 lang=swift
 *
 * [1013] Partition Array Into Three Parts With Equal Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // arr.count <- [3, 5 * 10^4]
    func canThreePartsEqualSum(_ arr: [Int]) -> Bool {
        let sum = arr.reduce(0, +)
        guard sum % 3 == 0 else { return false }
        let third = sum / 3
        var tmp = 0, cnt = 0
        var i = 0
        while i < arr.count {
            tmp += arr[i]
            if tmp == third {
                tmp = 0
                cnt += 1
                if cnt == 2 {
                    break
                }
            }
            i += 1
        }
        
        return cnt == 2 && i < arr.count - 1
    }
}
// @lc code=end

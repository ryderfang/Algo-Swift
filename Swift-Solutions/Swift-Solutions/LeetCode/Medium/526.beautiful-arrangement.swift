/*
 * @lc app=leetcode id=526 lang=swift
 *
 * [526] Beautiful Arrangement
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func countArrangement(_ n: Int) -> Int {
        guard n > 1 else { return 1 }
        func _solve(_ i: Int, _ tmp: inout [Int], _ cnt: inout Int) {
            guard i <= n else {
                cnt += 1
//                print(tmp)
                return
            }
            for j in 1...n {
                if tmp[j] == 0 && (i % j == 0 || j % i == 0) {
                    tmp[j] = 1
//                    print("\(i): \(j)")
                    _solve(i + 1, &tmp, &cnt)
                    tmp[j] = 0
                }
            }
        }
        var ans = 0
        var tmp = [Int](repeating: 0, count: n + 1)
        _solve(1, &tmp, &ans)
        return ans
    }
}
// @lc code=end


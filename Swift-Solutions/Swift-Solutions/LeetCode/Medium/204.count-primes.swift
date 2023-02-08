/*
 * @lc app=leetcode id=204 lang=swift
 *
 * [204] Count Primes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countPrimes(_ n: Int) -> Int {
        guard n > 1 else { return 0 }
        var p = [Bool](repeating: true, count: n)
        var plist = [Int]()
        for i in 2..<n {
            if p[i] {
                plist.append(i)
            }
            for x in plist {
                guard x * i < n else { break }
                p[x * i] = false
                if i % x == 0 {
                    break
                }
            }
        }
        return plist.count
    }
}
// @lc code=end


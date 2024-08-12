/*
 * @lc app=leetcode id=1653 lang=swift
 *
 * [1653] Minimum Deletions to Make String Balanced
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func minimumDeletions(_ s: String) -> Int {
        let s = Array(s)
        var (cnt, ans) = (0, 0)
        for c in s {
            if c == "b" { cnt += 1 }
            else if cnt != 0 {
                ans += 1
                cnt -= 1
            }
        }
        return ans
    }

    func minimumDeletions2(_ s: String) -> Int {
        let s = Array(s)
        let n = s.count
        // count of 'b' before i (not including)
        var bi = [Int](repeating: 0, count: n + 1)
        // count of 'a' after i (including)
        var ai = [Int](repeating: 0, count: n + 1)
        var cnt = 0
        for i in 1...n {
            if s[i-1] == "b" {
                cnt += 1
            }
            bi[i] = cnt
        }
        cnt = 0
        for i in stride(from: n - 1, through: 0, by: -1) {
            if s[i] == "a" {
                cnt += 1
            }
            ai[i] = cnt
        }
        var ret = n
        for i in 0...n {
            ret = min(ret, bi[i] + ai[i])
        }
        return ret
    }
}
// @lc code=end


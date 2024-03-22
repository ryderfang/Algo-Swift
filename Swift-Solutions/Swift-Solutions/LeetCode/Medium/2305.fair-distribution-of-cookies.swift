/*
 * @lc app=leetcode id=2305 lang=swift
 *
 * [2305] Fair Distribution of Cookies
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 背包
    func distributeCookies(_ cookies: [Int], _ k: Int) -> Int {
        let n = cookies.count
        func _solve(_ i: Int, _ n: Int, _ children: [Int]) -> Int {
            if i == n {
                return children.max() ?? 0
            }
            var ret = Int.max
            for j in 0..<k {
                var next = children
                next[j] += cookies[i]
                ret = min(ret, _solve(i + 1, n, next))
            }
            return ret
        }
        let children = [Int](repeating: 0, count: k)
        var ans = 0
        ans = _solve(0, n, children)
        return ans
    }
}
// @lc code=end

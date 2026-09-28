/*
 * @lc app=leetcode id=541 lang=swift
 *
 * [541] Reverse String II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func reverseStr(_ s: String, _ k: Int) -> String {
        let n = s.count
        var ans = ""
        for i in stride(from: 0, to: n, by: 2 * k) {
            ans += s[i..<min(i+k,n)].reversed()
            if i + k < n {
                ans += s[i+k..<min(i+2*k, n)]
            }
        }
        return ans
    }
}

fileprivate extension String {
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=917 lang=swift
 *
 * [917] Reverse Only Letters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func reverseOnlyLetters(_ s: String) -> String {
        let n = s.count
        guard n > 1 else { return s }
        var sa = Array(s)
        var (i, j) = (0, n - 1)
        while i < j {
            while i < j && !("a"..."z").contains(sa[i]) && !("A"..."Z").contains(sa[i]) {
                i += 1
            }
            while i < j && !("a"..."z").contains(sa[j]) && !("A"..."Z").contains(sa[j]) {
                j -= 1
            }
            if i < j {
                sa.swapAt(i, j)
                i += 1
                j -= 1
            }
        }
        return sa.map { String($0) }.joined()
    }
}
// @lc code=end


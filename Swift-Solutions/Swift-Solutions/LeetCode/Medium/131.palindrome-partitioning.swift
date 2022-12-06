/*
 * @lc app=leetcode id=131 lang=swift
 *
 * [131] Palindrome Partitioning
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func _isPalindrome(_ s: String) -> Bool {
        return s == String(s.reversed())
    }

    func partition(_ s: String) -> [[String]] {
        let n = s.count
        guard n > 1 else { return [[s]]}
        var ans = [[String]]()
        if _isPalindrome(s) {
            ans.append([s])
        }
        for i in 1..<n {
            let prefix = s[0..<i]
            if _isPalindrome(prefix) {
                let suffix = partition(s[i..<n])
                if suffix.count > 0 {
                    ans.append(contentsOf: suffix.map { [prefix] + $0 })
                }
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


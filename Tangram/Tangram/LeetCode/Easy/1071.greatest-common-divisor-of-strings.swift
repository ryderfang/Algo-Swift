/*
 * @lc app=leetcode id=1071 lang=swift
 *
 * [1071] Greatest Common Divisor of Strings
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // len <- [1, 1000]
    func gcdOfStrings(_ str1: String, _ str2: String) -> String {
        var n1 = str1.count
        var n2 = str2.count
        var arr1 = str1.map { String($0) }
        var arr2 = str2.map { String($0) }
        if n1 > n2 {
            (arr1, arr2) = (arr2, arr1)
            (n1, n2) = (n2, n1)
        }
        var count = 1
        var ans: String = ""
        while count <= n1 {
            if n1 % count == 0 {
                let tmp = arr1[0..<(n1/count)].joined()
                if _canDivided(arr1, tmp) && _canDivided(arr2, tmp) {
                    ans = tmp
                    break
                }
            }
            count += 1
        }
        
        func _canDivided(_ str: [String], _ div: String) -> Bool {
            let (n, m) = (str.count, div.count)
            guard m > 0 else { return false }
            guard n >= m && n % m == 0 else { return false }
            var i = 0
            while i < n {
                let tmp = str[i..<i+m].joined()
                if tmp != div {
                    break
                }
                i += m
            }
            return i == n
        }
        
        return ans
    }
}
// @lc code=end

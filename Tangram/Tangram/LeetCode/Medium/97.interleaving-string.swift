/*
 * @lc app=leetcode id=97 lang=swift
 *
 * [97] Interleaving String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let m = s1.count
        let n = s2.count
        let k = s3.count
        guard m + n == k else { return false }
        if m == 0 {
            return s2 == s3
        }
        if n == 0 {
            return s1 == s3
        }
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        for i in 0...m {
            for j in 0...n {
                if i == 0 && j == 0 {
                    dp[0][0] = 1
                    continue
                }
                if (j > 0 && dp[i][j-1] == 1 && s2[j-1] == s3[i+j-1]) || (i > 0 && dp[i-1][j] == 1 && s1[i-1] == s3[i+j-1]) {
                    dp[i][j] = 1
                } else {
                    dp[i][j] = 0
                }
            }
        }
        return dp[m][n] == 1
    }
}

fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }
}
// @lc code=end


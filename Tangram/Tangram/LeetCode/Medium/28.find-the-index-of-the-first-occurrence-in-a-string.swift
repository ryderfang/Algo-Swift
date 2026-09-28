/*
 * @lc app=leetcode id=28 lang=swift
 *
 * [28] Find the Index of the First Occurrence in a String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    /** 字符串匹配 **/
    func strStr(_ haystack: String, _ needle: String) -> Int {
        // n
        _ = haystack.count
        // m
        _ = needle.count
//        return bruteForce(haystack, needle)
//        return kmp(haystack, needle)
        return zAlgorithm(haystack, needle)
    }

    // 暴力算法
    func bruteForce(_ haystack: String, _ needle: String) -> Int {
        let text = haystack.map { String($0) }
        let pattern = needle.map { String($0) }
        let n = text.count, m = pattern.count
        guard n >= m else { return -1 }
        var ans = [Int]()
        for i in 0...n-m {
            var check = true
            for j in 0..<m {
                guard text[i+j] == pattern[j] else {
                    check = false
                    break
                }
            }
            if check {
                ans.append(i)
            }
        }
        return ans.count > 0 ? ans[0] : -1
    }

    // KMP algorithm
    func kmp(_ haystack: String, _ needle: String) -> Int {
        let LPS = { (str: String) -> [Int] in
            let pattern = str.map { String($0) }
            let m = pattern.count
            guard m > 0 else { return [] }
            var lps = [Int](repeating: 0, count: m)
            var i = 1, j = 0
            while i < m {
                if pattern[i] == pattern[j] {
                    j += 1
                    lps[i] = j
                    i += 1
                } else {
                    if j > 0 {
                        j = lps[j-1]
                    } else {
                        lps[i] = 0
                        i += 1
                    }
                }
            }
            return lps
        }(needle)

        print(LPS)

        let text = haystack.map { String($0) }
        let pattern = needle.map { String($0) }
        let n = text.count, m = pattern.count
        guard n >= m else { return -1 }
        var ans = [Int]()
        var i = 0, j = 0
        while i < n {
            if text[i] == pattern[j] {
                i += 1
                j += 1

                if j == m {
                    ans.append(i - j)
                    j = LPS[j-1]
                }
            } else {
                if j > 0 {
                    j = LPS[j-1]
                } else {
                    i += 1
                }
            }

        }
        return ans.count > 0 ? ans[0] : -1
    }

    // Z algorithm
    func zAlgorithm(_ haystack: String, _ needle: String) -> Int {
        let Z = { (str: String) -> [Int] in
            let s = str.map { String($0) }
            let n = str.count
            var z = [Int](repeating: 0, count: n)
            var l = 0, r = 0
            for i in 1..<n {
                if z[i - l] < r - i + 1 {
                    z[i] = z[i - l]
                } else {
                    z[i] = max(r - i + 1, 0)
                    while i + z[i] < n && s[z[i]] == s[i + z[i]] {
                        z[i] += 1
                    }
                    l = i
                    r = i + z[i] - 1
                }
            }
            return z
        }(needle + "$" + haystack)

        print(Z)

        let n = haystack.count, m = needle.count
        guard n >= m else { return -1 }
        var ans = [Int]()
        for i in m+1..<n+m+1 {
            if Z[i] == m {
                ans.append(i - m - 1)
            }
        }
        return ans.count > 0 ? ans[0] : -1
    }
}
// @lc code=end


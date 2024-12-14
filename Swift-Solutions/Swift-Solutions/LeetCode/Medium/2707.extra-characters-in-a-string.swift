/*
 * @lc app=leetcode id=2707 lang=swift
 *
 * [2707] Extra Characters in a String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func minExtraChar(_ s: String, _ dictionary: [String]) -> Int {
        let (n, dict) = (s.count, Set(dictionary))
        var dp = [Int](repeating: n, count: n + 1)
        dp[0] = 0
        for i in 1...n {
            for j in 0..<i {
                if dict.contains(s[j..<i]) {
                    dp[i] = min(dp[i], dp[j])
                } else {
                    dp[i] = min(dp[i], dp[j] + i - j)
                }
            }
        }
        return dp[n]
    }

    func minExtraChar1(_ s: String, _ dictionary: [String]) -> Int {
        let s = Array(s)
        let n = s.count
        var mem = [[Int]](repeating: [Int](repeating: -1, count: n), count: n)
        var dict = [String: Bool]()
        for word in dictionary {
            dict[word] = true
        }
        for i in 0..<n {
            for j in i..<n {
                let tmp = String(s[i...j])
                if dict[tmp, default: false] {
                    mem[i][j] = 0
                }
            }
        }
        func _solve(_ st: Int, _ ed: Int) -> Int {
            let cnt = ed - st + 1
            guard cnt > 0 else { return 0 }
            guard mem[st][ed] < 0 else { return mem[st][ed] }
            if cnt == 1 {
                mem[st][ed] = 1
                return 1
            }
            var ans = cnt
            for i in st+1...ed {
                let t1 = _solve(st, i-1)
                let t2 = _solve(i, ed)
                ans = min(ans, t1 + t2)
            }
            mem[st][ed] = ans
            return ans
        }
        let ret = _solve(0, n - 1)
        return ret
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


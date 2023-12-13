/*
 * @lc app=leetcode id=395 lang=swift
 *
 * [395] Longest Substring with At Least K Repeating Characters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: split and recursive
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        let s = Array(s)
        func _solve(_ arr: [Character], _ k: Int) -> Int {
            var mp = [Character: Int]()
            for c in arr {
                mp[c, default: 0] += 1
            }
            var split = [Int]()
            for (i, c) in arr.enumerated() {
                if mp[c, default: 0] < k {
                    split.append(i)
                }
            }
            if split.isEmpty {
                return arr.count
            }
            var ans = 0
            var (beg, end) = (0, 0)
            for i in split {
                end = i
                ans = max(ans, _solve(Array(arr[beg..<end]), k))
                beg = i + 1
            }
            ans = max(ans, _solve(Array(arr[beg...]), k))
            return ans
        }
        return _solve(s, k)
    }

    // substring - 需要连续
    func longestSubstring1(_ s: String, _ k: Int) -> Int {
        func _checkValid(_ mp: [Int: Int], _ k: Int) -> Bool {
            var ret = true
            for (_, v) in mp {
                if v > 0 && v < k {
                    ret = false
                    break
                }
            }
            return ret
        }

        // add end charactor $
        let s = Array(s + "$")
        let n = s.count
        var ans = 0
        var cnt = 1
        var arr = [(Int, Int)]()
        for i in 1..<n {
            if s[i] == s[i-1] {
                cnt += 1
            } else {
                arr.append((s[i-1].index(), cnt))
                cnt = 1
            }
        }
        let m = arr.count
        for i in 0..<m {
            var mp = [Int: Int]()
            var tmp = 0
            for j in i..<m {
                mp[arr[j].0, default: 0] += arr[j].1
                tmp += arr[j].1
                if _checkValid(mp, k) {
                    ans = max(ans, tmp)
                }
            }
        }
        return ans
    }
}

fileprivate extension Character {
    func index() -> Int {
        return Int(self.asciiValue! - 97)
    }
}

// @lc code=end

/*
 * @lc app=leetcode id=942 lang=swift
 *
 * [942] DI String Match
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution
    func diStringMatch(_ s: String) -> [Int] {
        var ma = 1
        var mi = -1
        let res = s.reduce(into: [0]) {
            if $1 == "I" {
                $0.append(ma)
                ma += 1
            } else {
                $0.append(mi)
                mi -= 1
            }
        }
        return res.map { $0 - mi - 1 }
    }

    func diStringMatch1(_ s: String) -> [Int] {
        let n = s.count
        var ans = [Int]()
        var has = Set<Int>()
        let first = s.filter { $0 == "D" }.count
        ans.append(first)
        has.insert(first)
        for ch in s {
            guard let last = ans.last else { break }
            if ch == "I" {
                for i in last+1...n {
                    if !has.contains(i) {
                        ans.append(i)
                        has.insert(i)
                        break
                    }
                }
            } else {
                for i in stride(from: last - 1, through: 0, by: -1) {
                    if !has.contains(i) {
                        ans.append(i)
                        has.insert(i)
                        break
                    }
                }
            }
        }
        return ans
    }
}
// @lc code=end


/*
 * @lc app=leetcode id=93 lang=swift
 *
 * [93] Restore IP Addresses
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func restoreIpAddresses(_ s: String) -> [String] {
        let n = s.count
        guard n >= 4 else { return [] }
        func _valid(_ s: String) -> Int? {
            let n = s.count
            guard n > 0 && n <= 3 else { return nil }
            guard let i = Int(s) else { return nil }
            if n == 1 {
                return i
            } else {
                guard s[0] != "0" else { return nil }
                return i < 256 ? i : nil
            }
        }

        func _ip(_ s: String, _ count: Int) -> [[Int]] {
            guard count > 0 else { return [] }
            let n = s.count
            guard n >= count else { return [] }
            if count == 1 {
                guard let i = _valid(s) else { return [] }
                return [[i]]
            }
            var ans = [[Int]]()
            for i in 0...min(2,n) {
                if n - i >= count, let first = _valid(s[0...i]) {
                    let next = _ip(s[i+1...n-1], count - 1)
                    if next.count > 0 {
                        ans.append(contentsOf: next.map { [first] + $0 })
                    }
                }
            }
            return ans
        }
        let ans = _ip(s, 4)
        return ans.map { $0.map { String($0) }.joined(separator: ".") }
    }
}

fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
            return self[self.index(self.startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }
}

// @lc code=end


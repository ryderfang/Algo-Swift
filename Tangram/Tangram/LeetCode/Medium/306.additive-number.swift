/*
 * @lc app=leetcode id=306 lang=swift
 *
 * [306] Additive Number
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // n <- [1, 35], 可能有大整数
    func isAdditiveNumber(_ num: String) -> Bool {
        let n = num.count
        guard n >= 3 else { return false }
        var checked = false
        var ans = [String]()
        func _checkNext(_ p0: Int, _ p1: Int, _ p2: Int) {
            guard !checked else { return }
            // leading zero check
            if p1 > p0 && num[p0] == "0" {
                return
            }
            if p2 > p1 + 1 && num[p1+1] == "0" {
                return
            }
            let a = num[p0...p1]
            let b = num[p1+1...p2]
            let c = num[p2+1...n-1]
            let sum = a.add(b)
            ans.append(a)
            if c.hasPrefix(sum) {
                let p3 = p2 + sum.count
                if p3 == n - 1 {
                    ans.append(contentsOf: [b, c])
                    checked = true
                    return
                }
                _checkNext(p1+1, p2, p3)
            } else {
                ans.removeLast()
            }
        }
        for i in 0..<n-2 {
            for j in i+1..<n-1 {
                guard !checked else { break }
                _checkNext(0, i, j)
            }
        }
        print(ans)
        return checked
    }
}

fileprivate extension String {
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    subscript (r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }

    // positive, no leading-zeros
    func add(_ rhs: String) -> String {
        var a = [Int]()
        var b = [Int]()
        a = self.reversed().map { Int(String($0))! }
        b = rhs.reversed().map { Int(String($0))! }
        let len = max(a.count, b.count)
        a.append(contentsOf: [Int](repeating: 0, count: len - a.count))
        b.append(contentsOf: [Int](repeating: 0, count: len - b.count))
        var carry: Int = 0
        for i in 0..<len {
            let tmp = a[i] + b[i] + carry
            a[i] = tmp % 10
            carry = tmp / 10
        }
        if carry > 0 {
            a.append(carry)
        }
        let ans = a.reversed().map { "\($0)" }.joined()
        return ans
    }
}

// @lc code=end


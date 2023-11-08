/*
 * @lc app=leetcode id=357 lang=swift
 *
 * [357] Count Numbers with Unique Digits
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func countNumbersWithUniqueDigits(_ n: Int) -> Int {
        let ans = [1, 10, 91, 739, 5275, 32491, 168571, 712891, 2345851]
        return ans[n]
    }

    // Better solution
    // 1 + 9 + 9 * 9 + 9 * 9 * 8 + ...
    func countNumbersWithUniqueDigits1(_ n: Int) -> Int {
        guard n > 0 else { return 1 }
        var x = 1
        for i in 1...n {
            var result = 9

            for j in 1..<i {
                result *= 10 - j
            }
            x += result
        }

        return x
    }

    // -- Brute Force
    func isGood(_ n: Int) -> Bool {
        var x = n
        var cnt = 0
        var st = Set<Int>()
        while x > 0 {
            cnt += 1
            st.insert(x % 10)
            x /= 10
        }
        return st.count == cnt
    }

    func preCalc() {
        var ans = 0
        var tmp = 1
        for i in 0...100000000 {
            if i == tmp {
                print("\(i): \(ans)")
                tmp *= 10
            }
            if isGood(i) {
                ans += 1
            }
        }
    }
}
// @lc code=end


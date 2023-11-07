/*
 * @lc app=leetcode id=357 lang=swift
 *
 * [357] Count Numbers with Unique Digits
 */

// @lc code=start
class Solution {
    func countNumbersWithUniqueDigits(_ n: Int) -> Int {
        let ans = [1, 10, 91, 739, 5275, 32491, 168571, 712891, 2345851]
        return ans[n]
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


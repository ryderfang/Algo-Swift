/*
 * @lc app=leetcode id=788 lang=swift
 *
 * [788] Rotated Digits
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution (more elegant)
    func rotatedDigits(_ n: Int) -> Int {
        let tbl: [Character: String] = [
            "0": "0",
            "1": "1",
            "2": "5",
            "5": "2",
            "6": "9",
            "8": "8",
            "9": "6"
        ]
        func _isOk(_ i: Int) -> Bool {
            let ok = String(i)
            let ko = ok.map { tbl[$0, default: ""] }.joined()
            return ok.count == ko.count && ok != ko
        }
        
        return (1...n).filter(_isOk).count
    }
    
    // n <- [1, 1e4]
    // 0, 1, 8 -> 0, 1, 8
    // 2 <-> 5
    // 6 <-> 9
    func rotatedDigits1(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        let validDigits = Set<Int>([0, 1, 2, 5, 6, 8, 9])
        let validRotate = Set<Int>([2, 5, 6, 9])
        for i in 1...n {
            var tmp = i
            var valid = 2
            while tmp > 0 {
                let digit = tmp % 10
                if !validDigits.contains(digit) {
                    valid = 0
                    break
                }
                if validRotate.contains(digit) {
                    valid = 1
                }
                tmp /= 10
            }
            if valid == 1 {
                dp[i] = dp[i-1] + 1
            } else {
                dp[i] = dp[i-1]
            }
        }
        return dp[n]
    }
}
// @lc code=end

